@echo off
setlocal enabledelayedexpansion

:: Prompt for project name
set /p project_name="Enter your project name: "

:: Set base path to F drive
set base_path=F:\%project_name%
mkdir "%base_path%"
cd /d "%base_path%"

echo Creating folder structure in F:\%project_name%...
mkdir templates
mkdir static
mkdir static\css
mkdir static\js

echo Creating virtual environment...
python -m venv venv

echo Activating virtual environment and installing Flask...
call venv\Scripts\activate.bat
pip install flask

echo Generating requirements.txt...
pip freeze > requirements.txt

echo Writing app.py...
(
echo from flask import Flask, render_template
echo.
echo app = Flask(__name__)
echo.
echo @app.route("/")
echo def home():
echo     return render_template("index.html")
echo.
echo if __name__ == "__main__":
echo     app.run(debug=True)
) > app.py

echo Writing index.html...
(
echo ^<!DOCTYPE html^>
echo ^<html lang="en"^>
echo ^<head^>
echo     ^<meta charset="UTF-8"^>
echo     ^<meta name="viewport" content="width=device-width, initial-scale=1.0"^>
echo     ^<title^>Home^</title^>
echo     ^<link rel="stylesheet" href="{{ url_for('static', filename='css/index.css') }}"^>
echo ^</head^>
echo ^<body^>
echo     ^<h1^>Welcome to %project_name%^</h1^>
echo     ^<script src="{{ url_for('static', filename='js/index.js') }}"^>^</script^>
echo ^</body^>
echo ^</html^>
) > templates\index.html

echo Creating empty CSS and JS files...
type nul > static\css\index.css
type nul > static\js\index.js

echo.
echo 🔥 Project "%project_name%" created successfully at F:\%project_name%
echo ✅ Flask installed
echo 📄 requirements.txt generated
echo 🚀 Ready to start coding!

pause
