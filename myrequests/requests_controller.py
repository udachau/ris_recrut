from flask import Blueprint, render_template, request, session
from dbcm import UseDatabase
from checker import check_role

requests_bp = Blueprint('requests_bp', __name__, template_folder='templates')

def make_request(cursor, sql, values, keys):
    """Универсальная функция для выполнения запросов."""
    cursor.execute(sql, values)
    result = cursor.fetchall()
    return [dict(zip(keys, line)) for line in result]


@requests_bp.route('/request1', methods=['GET'])
@check_role
def request1():

    sql = '''
        SELECT o.opening_id AS opening_id,
               p.job_name AS job_name,
               DATEDIFF(NOW(), o.open_date) AS days_open
        FROM openings o
        JOIN positions p ON o.position_id = p.position_id
        WHERE o.close_date IS NULL;
    '''
    keys = ['opening_id', 'job_name', 'days_open']

    try:
        with UseDatabase(session['db_config']) as cursor:
            result = make_request(cursor, sql, (), keys)
            if not result:
                return render_template('no_data.html', message="Нет открытых вакансий.")
            return render_template('request1_result.html', table=result)
    except Exception as e:
        return render_template('error.html', error_msg=str(e))



@requests_bp.route('/request2', methods=['GET', 'POST'])
@check_role
def request2():
    if request.method == 'POST':
        division_code = request.form.get('division_code')

        if not division_code:
            return render_template('error.html', error_msg="Не указан код отдела!")

        sql = '''
            SELECT e.employee_id, e.name, e.birth_date, e.address, e.education, 
                   e.position_id, e.salary, e.enrollment_date, e.dismissal_date
            FROM employees e
            JOIN positions p ON e.position_id = p.position_id
            WHERE p.division_code = %s 
            AND e.birth_date = (
                SELECT MAX(e2.birth_date)
                FROM employees e2
                JOIN positions p2 ON e2.position_id = p2.position_id
                WHERE p2.division_code = %s
            );
        '''
        keys = ['employee_id', 'name', 'birth_date', 'address', 'education', 
                'position_id', 'salary', 'enrollment_date', 'dismissal_date']

        try:
            with UseDatabase(session['db_config']) as cursor:
                result = make_request(cursor, sql, (division_code, division_code), keys)
                if not result:
                    return render_template('no_data.html', message="Нет сотрудников в данном отделе.")
                return render_template('request2_result.html', table=result)
        except Exception as e:
            return render_template('error.html', error_msg=str(e))

    return render_template('params_form_enter_depart_name.html', param_name='код отдела', action_url='/request2')



@requests_bp.route('/request3', methods=['GET', 'POST'])
@check_role
def request3():
    if request.method == 'POST':
        year = request.form.get('year')

        if not year or not year.isdigit():
            return render_template('error.html', error_msg="Укажите год в числовом формате!")

        year = int(year)

        sql = '''
            SELECT p.*
            FROM positions p
            WHERE NOT EXISTS (
                SELECT 1
                FROM openings o
                WHERE p.position_id = o.position_id AND YEAR(o.open_date) = %s
            );
        '''
        keys = ['position_id', 'job_name', 'division_code']

        try:
            with UseDatabase(session['db_config']) as cursor:
                result = make_request(cursor, sql, (year,), keys)
                if not result:
                    return render_template('no_data.html', message="Все позиции имели вакансии в указанном году.")
                return render_template('request3_result.html', table=result)
        except Exception as e:
            return render_template('error.html', error_msg=str(e))

    return render_template('params_form_enter_year.html', param_name='год', action_url='/request3')

