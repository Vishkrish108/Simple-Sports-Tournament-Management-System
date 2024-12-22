from flask import Blueprint, render_template, request, redirect, session, url_for, flash
from functools import wraps
from db import get_db

user_bp = Blueprint('user', __name__)

# View access to tournaments by start date, search by sport      search for player???

@user_bp.route('/apply', methods=['GET', 'POST'])
def apply():
    db=get_db()
    cur=db.cursor

    if request.method == 'POST':
        try:
            team_name = request.form['team_name']
            home_ground = request.form['home_ground']
            team_captain = request.form['team_captain']
            coach_id = request.form['coach_id']
            game_name= request.form['game_name']
            manager=request.form['manager']
            team_merch = request.form['team_merch']
            tournament_id=request.form['tournament_id']

            values = [team_name, home_ground, team_captain, coach_id, game_name, manager, team_merch, tournament_id]
            column_names = ["team_name", "home_ground", "team_captain", "coach_id", "game_name", "manager", "team_merch", "tournament_id"]

            if 'add' in request.form:    
                # Parameterized query for insertion
                query = f"INSERT INTO teams ({', '.join(column_names)}) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)"
                cur.execute(query, values)
                
                flash('Team added successfully', 'success')
            
        except Exception as e:
            db.rollback()
            flash('An error occurred: ' + str(e), 'error')
        finally:
            cur.close()
        return redirect(url_for('user.user'))

    cur.execute('SELECT team_id, team_name, home_ground, team_captain, coach_id, game_name, manager, team_merch, tournament_id FROM teams')
    teams = cur.fetchall()
    cur.close()
    return render_template('apply.html', teams=teams)    


# @user_bp.route('tournaments', methods=['GET', 'POST'])
# def tournaments_view():
#     db = get_db()
#     cur = db.cursor()
#     cur.execute('''
#     SELECT t.tournament_id, t.tournament_name, t.start_date, t.end_date FROM tournament
#     ''')
#     tournaments = cur.fetchall()
#     cur.close()

#     return render_template('tournament_view.html', tournaments=tournaments)

@user_bp.route('/tournaments', methods=['GET', 'POST'])
def Tournaments_view():
    db = get_db()
    cur = db.cursor()

    if request.method == 'POST':
        tournament_name = request.form.get('tournament_name')
        start_date = request.form.get('start_date')
        end_date = request.form.get('end_date')

        # Call the stored procedure to validate dates and insert the tournament
        try:
            # Execute the stored procedure with the provided inputs
            cur.callproc('validate_tournament_dates', [tournament_name, start_date, end_date])

            # Commit the transaction (if the procedure doesn't raise an error)
            db.commit()

            flash('Tournament added successfully', 'success')

            # Fetch updated tournament details
            cur.execute('''
                SELECT tournament_id, tournament_name, start_date, end_date,
                    get_tournament_status(start_date, end_date) AS status
                FROM tournament
            ''')
            tournaments = cur.fetchall()

            cur.close()

            return render_template('Tournaments_view.html', tournaments=tournaments)

        except Exception as e:
            db.rollback()  # Rollback in case of any error
            flash(f"An error occurred: {str(e)}", 'error')
            cur.close()
            return redirect(url_for('user.Tournaments_view'))

    # If it's a GET request, fetch and display the list of tournaments
    cur.execute('''
        SELECT tournament_id, tournament_name, start_date, end_date,
            get_tournament_status(start_date, end_date) AS status
        FROM tournament
    ''')
    tournaments = cur.fetchall()
    cur.close()

    return render_template('Tournaments_view.html', tournaments=tournaments)


@user_bp.route('/teams', methods=['GET', 'POST'])
def teams_view():
    db = get_db()
    cur = db.cursor()

    # Get tournament_id from request arguments or form, with a fallback to a default value (e.g., 1)
    tournament_id = request.args.get('tournament_id') or request.form.get('tournament_id') or 1

    # Fetch tournament details only for the selected tournament_id
    cur.execute('''
    SELECT team_id, team_name, game.game_name, teams.tournament_id, game_id, 
           team_1, team_2, team1_score, team2_score
    FROM ((teams 
            JOIN game ON teams.game_name = game.game_name) 
            JOIN score ON game.game_name = score.game_name) 
            JOIN tournament ON tournament.tournament_id = teams.tournament_id
    WHERE teams.tournament_id = %s
    ''', (tournament_id,))  # Dynamically filter by tournament_id
    teams = cur.fetchall()

    if request.method == 'POST':
        teams_id = request.form.get('team_id')
        if teams_id:
            cur.execute('SELECT COUNT(*) FROM teams WHERE team_id = %s', (teams_id,))
            if cur.fetchone()[0] > 0:
                cur.close()
                return redirect(url_for('user.players', teams_id=teams_id))
        flash('Invalid Team ID. Please try again.', 'error')

    cur.close()
    return render_template('teams_view.html', teams=teams)

@user_bp.route('/players', methods=['GET', 'POST'])
def players():
    db = get_db()
    cur = db.cursor()

    # Fetch tournament details
    cur.execute('''
    SELECT player_id, name, team_id, age FROM players
    ''')
    players = cur.fetchall()
    cur.close()
    return render_template('players.html', players=players)

@user_bp.route('/eligibility_check', methods=['GET', 'POST'])
def eligibility_check():
    db = get_db()
    cur=db.cursor()

    cur.execute('''
    SELECT 
        t.team_id, t.team_name, t.game_name, t.tournament_id
    FROM 
        teams t
    JOIN 
        players p ON t.team_id = p.team_id
    WHERE 
        t.team_id IN (
            SELECT 
                team_id
            FROM 
                players
            GROUP BY 
                team_id
            HAVING 
                MAX(age) < 20
        );
    ''')
    eligible=cur.fetchall()
    cur.close()

    return render_template('eligibility_check.html', eligible=eligible)
