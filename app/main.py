from flask import Flask, request


app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def receiver():
    if request.method == 'POST':
        return "POST"
    return "GET"



if __name__ == '__main__':
    app.run()

