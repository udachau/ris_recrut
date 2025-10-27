import json
from flask import Flask, render_template, redirect, url_for, session, request
from checker import check_role
from authorization.login import auth_blueprint
from authorization.registration import reg_blueprint
from vacancy.vac import vacancy_bp
from personal_cabinet.cabinet import cabinet_bp
from add_interview.add_interview import interview_bp
from myrequests.requests_controller import requests_bp
from report.report import report_bp

app = Flask(__name__)

app.register_blueprint(auth_blueprint)
app.register_blueprint(vacancy_bp)
app.register_blueprint(cabinet_bp)
app.register_blueprint(reg_blueprint)
app.register_blueprint(interview_bp)
app.register_blueprint(requests_bp)
app.register_blueprint(report_bp)

with open('data_files/secret_key.json') as f:
    app.secret_key = json.load(f)['secret_key']

def filter_menu_by_role(menu, user_role):
    with open('data_files/roles.json', encoding='utf-8') as f:
        role_mapping = json.load(f)

    accessible_urls = [item['url'] for item in role_mapping if user_role in item['roles']]

    route_mapping = {
        'requests': '/requests',
        'make': '/add_interview',
        'reports': '/report',
        'vacancies': '/vacancies',
        'cabinet': '/cabinet',
        'exit': '/'
    }

    def is_accessible(menu_item):
        menu_url = route_mapping.get(menu_item['url'].replace('?req=', ''), None)
        return menu_url in accessible_urls

    filtered_menu = [item for item in menu if is_accessible(item)]
    return filtered_menu

@app.route('/requests', methods=["GET", "POST"])
@check_role
def requests_menu():
    req = request.args.get('req')

    with open('data_files/requests_menu.json', encoding='utf-8') as f:
        r_menu = json.load(f)

    route_mapping = {
        '1': url_for('requests_bp.request1'),
        '2': url_for('requests_bp.request2'),
        '3': url_for('requests_bp.request3'),
        'exit': url_for('menu')
    }

    if req is None:
        return render_template('requests_ menu.html', menu=r_menu,
                               user=session['db_config']['user'])
    else:
        return redirect(route_mapping.get(req, url_for('menu')))

@app.route('/', methods=["GET", "POST"])
@check_role
def menu():
    with open('data_files/menu.json', encoding='utf-8') as f:
        main_menu = json.load(f)

    user_role = session.get('db_config', {}).get('user', 'guest')  

    filtered_menu = filter_menu_by_role(main_menu, user_role)

    req = request.args.get('req')

    route_mapping = {
        'requests': url_for('requests_menu'),
        'make': url_for('interview_bp.add_interview'),
        'reports': url_for('report_bp.list_reports'),
        'vacancies': url_for('vacancy_bp.vacancies'),
        'cabinet': url_for('cabinet_bp.cabinet'),
        'exit': 'exit.html'
    }

    if req is None:
        return render_template('menu.html', menu=filtered_menu,
                               user=session['db_config']['user'], password=session['db_config']['password'])
    if req != 'exit':
        return redirect(route_mapping[req])
    else:
        session.pop('user_info', None)
        session.pop('db_config', None)
        return render_template(route_mapping[req])

if __name__ == '__main__':
    app.run(debug=True)
