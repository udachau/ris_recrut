from flask import Blueprint, render_template, request, session, redirect, url_for
from checker import check_role
from dbcm import UseDatabase
from sql_provider import SQLProvider
import datetime

interview_bp = Blueprint('interview_bp', __name__, template_folder='templates')

sql_provider = SQLProvider("add_interview/sql")

@interview_bp.route('/add_interview', methods=['GET', 'POST'])
@check_role
def add_interview():

    # Этап 1: Выбор вакансии
    if request.method == 'POST' and 'position_id' in request.form:
        session["selected_position"] = request.form['position_id']

        query = sql_provider.get("get_candidates.sql")
        with UseDatabase(session['db_config']) as cursor:
            cursor.execute(query, (session["selected_position"],)) 
            candidates = cursor.fetchall()

        session["available_candidates"] = [
            {"candidate_id": row[0], "name": row[1], "age": row[2], "gender": row[3], "city": row[4]}
            for row in candidates
        ]
        session["selected_candidates"] = []

        return redirect(url_for('interview_bp.add_interview'))

    # Этап 2: Выбор кандидатов
    if request.method == 'POST' and 'select_candidate' in request.form:
        candidate_id = int(request.form['select_candidate'])

        available = session.get("available_candidates", [])
        selected = session.get("selected_candidates", [])

        candidate = next((c for c in available if c["candidate_id"] == candidate_id), None)
        if candidate and len(selected) < 5:
            available.remove(candidate)
            selected.append(candidate)

        session["available_candidates"] = available
        session["selected_candidates"] = selected

        return redirect(url_for('interview_bp.add_interview'))

    if request.method == 'POST' and 'unselect_candidate' in request.form:
        candidate_id = int(request.form['unselect_candidate'])

        available = session.get("available_candidates", [])
        selected = session.get("selected_candidates", [])

        candidate = next((c for c in selected if c["candidate_id"] == candidate_id), None)
        if candidate:
            selected.remove(candidate)
            available.append(candidate)

        session["available_candidates"] = available
        session["selected_candidates"] = selected

        return redirect(url_for('interview_bp.add_interview'))

    # Этап 3: Выбор даты собеседования
    if request.method == 'POST' and 'interview_date' in request.form:
        interview_date = request.form['interview_date']

        if datetime.datetime.strptime(interview_date, "%Y-%m-%d").date() < datetime.datetime.today().date():
            return render_template(
                'addform.html',
                positions=session.get("positions", []),
                selected_position=session.get('selected_position'),
                available_candidates=session.get('available_candidates'),
                selected_candidates=session.get('selected_candidates'),
                interview_date=None,
                today_date=datetime.datetime.today().strftime('%Y-%m-%d'),
                error_message="❌ Нельзя выбрать дату в прошлом!"
            )

        session["interview_date"] = interview_date

        return redirect(url_for('interview_bp.add_interview'))

    # Этап 4: Подтверждение собеседования
    if request.method == 'POST' and 'confirm' in request.form:
        return redirect(url_for('interview_bp.finalize_interview'))

    if request.method == 'POST' and 'update_date' in request.form:
        new_date = request.form['new_interview_date']

        if datetime.datetime.strptime(new_date, "%Y-%m-%d").date() < datetime.datetime.today().date():
            return render_template(
                'addform.html',
                positions=session.get("positions", []),
                selected_position=session.get("selected_position"),
                available_candidates=session.get("available_candidates"),
                selected_candidates=session.get("selected_candidates"),
                interview_date=session.get("interview_date"),
                today_date=datetime.datetime.today().strftime("%Y-%m-%d"),
                step_confirm=True,
                error_message="❌ Нельзя выбрать дату в прошлом!"
            )

        session["interview_date"] = new_date
        return redirect(url_for('interview_bp.add_interview'))

    query = sql_provider.get("get_openings.sql")
    with UseDatabase(session['db_config']) as cursor:
        cursor.execute(query)
        positions = cursor.fetchall()

    positions = [{"opening_id": row[0], "job_name": row[1]} for row in positions]

    return render_template(
        'addform.html',
        positions=positions,
        selected_position=session.get("selected_position"),
        available_candidates=session.get("available_candidates"),
        selected_candidates=session.get("selected_candidates"),
        interview_date=session.get("interview_date"),
        today_date=datetime.datetime.today().strftime("%Y-%m-%d")
    )

@interview_bp.route('/success', methods=['GET'])
@check_role
def success_page():
    """Страница успешного назначения собеседования"""
    return render_template('success.html', success_message="Собеседование успешно назначено!")

@interview_bp.route('/finalize_interview', methods=['POST', 'GET'])
@check_role
def finalize_interview():
    """Финальное сохранение собеседования в БД"""

    print("DEBUG: начало finalize_interview()")

    position_id = session.get("selected_position")
    selected_candidates = session.get("selected_candidates", [])
    interview_date = session.get("interview_date")

    idcheck_users = session['user_info']['user_id']
    print(f"DEBUG: idcheck_users = {idcheck_users}")

    query = sql_provider.get("get_employee_id.sql")
    print(f"DEBUG: SQL-запрос на employee_id = {query}")

    try:
        with UseDatabase(session['db_config']) as cursor:
            cursor.execute(query, (idcheck_users,))
            result = cursor.fetchone()
            print(f"DEBUG: employee_id результат = {result}")
    except Exception as e:
        print(f"ERROR: Ошибка получения employee_id: {e}")
        return render_template('addform.html', error_message="Ошибка: сотрудник не найден!")

    if not result:
        print("ERROR: employee_id не найден в БД")
        return render_template('addform.html', error_message="Ошибка: сотрудник не найден!")

    employee_id = result[0]
    print(f"DEBUG: Найденный employee_id = {employee_id}")

    if not position_id or not selected_candidates or not interview_date:
        print("ERROR: Не все данные выбраны!")
        return render_template('addform.html', error_message="Не все данные выбраны!")

    try:
        print("DEBUG: Проверка существующего собеседования...")

        with UseDatabase(session['db_config']) as cursor:
            for candidate in selected_candidates:
                candidate_id = candidate["candidate_id"]
                check_query = """
                SELECT COUNT(*) 
                FROM interviews i
                WHERE i.date = %s 
                AND i.employee_id = %s 
                AND i.opening_id = %s; 
                """
                cursor.execute(check_query, (interview_date, employee_id, position_id))
                existing_count = cursor.fetchone()[0]

                if existing_count > 0:
                    print(f"ERROR: Собеседование уже существует для кандидата {candidate_id}!")
                    return render_template(
                        'addform.html',
                        positions=session.get("positions", []),
                        selected_position=session.get("selected_position"),
                        available_candidates=session.get("available_candidates"),
                        selected_candidates=session.get("selected_candidates"),
                        interview_date=session.get("interview_date"),
                        today_date=datetime.datetime.today().strftime("%Y-%m-%d"),
                        error_message=f"❌ Собеседование уже назначено на {interview_date}!"
                    )

        print("DEBUG: Начинаем запись в БД...")

        with UseDatabase(session['db_config']) as cursor:
            query = sql_provider.get("insert_interview.sql")
            print(f"DEBUG: SQL-вставка интервью = {query}")
            cursor.execute(query, (interview_date, employee_id, position_id))
            interview_id = cursor.lastrowid  
            print(f"DEBUG: Собеседование добавлено с ID = {interview_id}")

            for candidate in selected_candidates:
                candidate_id = candidate["candidate_id"]
                query = sql_provider.get("update_response_status.sql")
                print(f"DEBUG: Обновляем статус для candidate_id {candidate_id}")
                cursor.execute(query, (position_id, candidate_id))

            cursor.connection.commit()

        print("DEBUG: Коммит выполнен успешно!")

        session.pop("selected_position", None)
        session.pop("available_candidates", None)
        session.pop("selected_candidates", None)
        session.pop("interview_date", None)

        return redirect(url_for('interview_bp.success_page'))

    except Exception as e:
        print(f"ERROR: Ошибка при выполнении коммита: {e}")
        return render_template('addform.html', error_message="Ошибка, попробуйте позже.")
    
@interview_bp.route('/cancel_interview', methods=['GET'])
def cancel_interview():
    session.pop("selected_position", None)
    session.pop("available_candidates", None)
    session.pop("selected_candidates", None)
    session.pop("interview_date", None)

    return redirect('/')
