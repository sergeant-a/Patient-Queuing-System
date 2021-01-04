import pymysql
from app import app
from db_config import mysql
from flask import jsonify
from flask import flash, request

		
@app.route('/user/add', methods=['POST'])
def add_user():
	
	conn = mysql.connect()
	cursor = conn.cursor()
	try:
		_json = request.json
		_name = _json['name']
		_contact = _json['contact']
		_age = _json['age']
		_sex = _json['sex']
		_token = _json['token']
		# validate the received values
		
		if _name and _contact and _age and _sex and _token and request.method == 'POST':
			

			
			# save edits
			
			sql = "INSERT INTO personal_info (Patient_Name, Contact_No, Age, Sex, Token_No) VALUES(%s, %s, %s, %s, %s)"
			data = (_name, _contact, _age, _sex, _token)
			cursor.execute(sql, data)
			conn.commit()
			resp = jsonify('User added successfully!')
			resp.status_code = 200
			return resp
		
			
		else:
			return not_found()
	except Exception as e:
		print(e)

	finally:
		cursor.close() 
		conn.close()
		
	return ""
	
		
@app.route('/user/users')
def users():
	try:
		conn = mysql.connect()
		cursor = conn.cursor(pymysql.cursors.DictCursor)
		cursor.execute("SELECT * FROM personal_info")
		rows = cursor.fetchall()
		resp = jsonify(rows)
		resp.status_code = 200
		return resp
	except Exception as e:
		print(e)
	finally:
		cursor.close() 
		conn.close()
		
@app.route('/user/user/<int:Sr_No>')
def user(Sr_No):
	try:
		conn = mysql.connect()
		cursor = conn.cursor(pymysql.cursors.DictCursor)
		cursor.execute("SELECT * FROM personal_info WHERE Sr_No=%s", Sr_No)
		row = cursor.fetchone()
		resp = jsonify(row)
		resp.status_code = 200
		return resp
	except Exception as e:
		print(e)
	finally:
		cursor.close() 
		conn.close()
	return""

@app.route('/user/update', methods=['POST'])
def update_user():
	conn = mysql.connect()
	cursor = conn.cursor()
	try:
		_json = request.json
		_srno = _json['Sr_No']
		_name = _json['Patient_Name']
		_contact = _json['Contact_No']
		_age = _json['Age']
		_sex = _json['Sex']
		_token = _json['Token_No']
		# validate the received values
		if _name and _contact and _age and _sex and _token and _srno and request.method == 'POST':

			
			# save edits
			sql = "UPDATE personal_info SET Patient_Name=%s, Contact_No=%s, Age=%s, Sex=%s, Token_No=%s WHERE Sr_No=%s"
			data = (_name, _contact, _age, _sex, _token, _srno)
			
			cursor.execute(sql, data)
			conn.commit()
			resp = jsonify('User updated successfully!')
			resp.status_code = 200
			return resp
		else:
			return not_found()
	except Exception as e:
		print(e)
	finally:
		cursor.close() 
		conn.close()
	return""
		
@app.route('/user/delete/<int:id>')
def delete_user(id):
	try:
		conn = mysql.connect()
		cursor = conn.cursor()
		cursor.execute("DELETE FROM personal_info WHERE Sr_No=%s", (id,))
		cursor.execute("ALTER TABLE personal_info DROP Sr_No")
		cursor.execute("ALTER TABLE personal_info ADD Sr_No int not null auto_increment primary key first")
		conn.commit()
		resp = jsonify('User deleted successfully!')
		resp.status_code = 200
		return resp
	except Exception as e:
		print(e)
	finally:
		cursor.close() 
		conn.close()
	return""






@app.route('/appt/add', methods=['POST'])
def add_appt():
	
	conn = mysql.connect()
	cursor = conn.cursor()
	try:
		_json = request.json
		_token = _json['Token_No']
		_dept = _json['Department']
		_doc_name = _json['Doctor_Name']
		_date = _json['Date']
		
		# validate the received values
		
		if _doc_name and _dept and _date and _token and request.method == 'POST':
			

			
			# save edits
			
			sql = "INSERT INTO appointment_info (Token_No, Department, Doctor_Name, Date) VALUES(%s, %s, %s, %s)"
			data = (_token, _dept, _doc_name, _date)
			cursor.execute(sql, data)
			conn.commit()
			resp = jsonify('Appointment added successfully!')
			resp.status_code = 200
			return resp
		
			
		else:
			return not_found()
	except Exception as e:
		print(e)

	finally:
		cursor.close() 
		conn.close()
		
	return ""
	
		
@app.route('/appt/users', methods=['GET'])
def appts():
	try:
		conn = mysql.connect()
		cursor = conn.cursor(pymysql.cursors.DictCursor)
		cursor.execute("SELECT * FROM appointment_info")
		rows = cursor.fetchall()
		resp = jsonify(rows)
		resp.status_code = 200
		return resp
	except Exception as e:
		print(e)
	finally:
		cursor.close() 
		conn.close()
		
@app.route('/appt/user/<int:Token_No>')
def appt(Token_No):
	try:
		conn = mysql.connect()
		cursor = conn.cursor(pymysql.cursors.DictCursor)
		cursor.execute("SELECT * FROM appointment_info WHERE Token_No=%s", Token_No)
		row = cursor.fetchone()
		resp = jsonify(row)
		resp.status_code = 200
		return resp
	except Exception as e:
		print(e)
	finally:
		cursor.close() 
		conn.close()
	return""


@app.route('/appt/update', methods=['POST'])
def update_appt():
	conn = mysql.connect()
	cursor = conn.cursor()
	try:
		_json = request.json
		_token = _json['Token_No']
		_dept = _json['Department']
		_doc_name = _json['Doctor_Name']
		_date = _json['Date']
		
		# validate the received values
		
		if _doc_name and _dept and _date and _token and request.method == 'POST':

			
			# save edits
			sql = "UPDATE appointment_info SET Department=%s, Doctor_Name=%s, Date=%s WHERE Token_No=%s"
			data = (_dept, _doc_name, _date, _token)
			
			cursor.execute(sql, data)
			conn.commit()
			resp = jsonify('Appointment updated successfully!')
			resp.status_code = 200
			return resp
		else:
			return not_found()
	except Exception as e:
		print(e)
	finally:
		cursor.close() 
		conn.close()
	return""
		
@app.route('/appt/delete', methods=['POST'])
def delete_appt():
	conn = mysql.connect()
	cursor = conn.cursor()
	try:
		_json = request.json
		_token = _json['Token_No']
		if _token and request.method == 'POST':
				
			cursor.execute("DELETE FROM appointment_info WHERE Token_No=%s", (_token,))
	
			conn.commit()
			resp = jsonify('Appointment deleted successfully!')
			resp.status_code = 200
			return resp
	except Exception as e:
		print(e)
	finally:
		cursor.close() 
		conn.close()
	return""



		
@app.errorhandler(404)
def not_found(error=None):
    message = {
        'status': 404,
        'message': 'Not Found: ' + request.url,
    }
    resp = jsonify(message)
    resp.status_code = 404

    return resp
		
if __name__ == "__main__":
    app.run(host='0.0.0.0', debug=True)