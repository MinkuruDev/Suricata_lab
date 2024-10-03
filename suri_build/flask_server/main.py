from flask import Flask, request, render_template

app = Flask(__name__)

@app.route('/')
def index():
    # Get the page query parameter, default to 1 if not provided
    page = request.args.get('page', default=1, type=int)
    
    # Render the corresponding page HTML file, default to page1.html
    template_name = f"page{page}.html"
    
    try:
        return render_template(template_name)
    except:
        # Return 404 error if the page doesn't exist
        return "Page not found", 404

if __name__ == '__main__':
    # Run the Flask app on port 80
    app.run(host='0.0.0.0', port=80)
