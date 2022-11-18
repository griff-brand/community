"""
Applet: Is It Friday the 13th
Summary: Is it Friday the 13th: yes/no
Description: Is it Friday the 13th: yes/no.
Author: Brandon Griffeth
"""

load("render.star", "render")
load("time.star", "time")
load("encoding/json.star", "json")
load("encoding/base64.star", "base64")

TREE_IMG_NO_LIGHTS = base64.decode("""
iVBORw0KGgoAAAANSUhEUgAAAAsAAAALCAYAAACprHcmAAAAAXNSR0IArs4c6QAAAExJREFUKFNjZMACfNYH/N8SuIERXQpDAKQQpghdA/mKkU3FZjqKyUQrxqYQ3XS4yUQrxqcQ2XSwySQpRg/8ylCP/+2rdxCOFJBGXIoBe08sDMFoReYAAAAASUVORK5CYII=
""")

TREE_IMG_1 = base64.decode("""
iVBORw0KGgoAAAANSUhEUgAAAAsAAAALCAYAAACprHcmAAAAAXNSR0IArs4c6QAAAGtJREFUKFNjZMACfNYH/N8SuIERXQpDAKQQpghdA/mKkU2dmy/MkDzxLQOy6SgmIyvG5hS4YmwK0TVgKIZZv/nlBgZf8QCwephTwIrxmYpsOopiZNNgipA9ihF0IEWVoR7/21fvIBwp+BQDAKXIOwz136MKAAAAAElFTkSuQmCC
""")

TREE_IMG_2 = base64.decode("""
iVBORw0KGgoAAAANSUhEUgAAAAsAAAALCAYAAACprHcmAAAAAXNSR0IArs4c6QAAAHRJREFUKFNjZMACfNYH/N8SuIERXQpDAKQQpghdA4biOeob/m/oWABWj1cxiqm8LQw+n2tQNKCYjKwYm1PgirEpRNeAoXgL1PqAigQGdLeDFYNMRZbEFpwgz8IVY1UAtQUWMhhBB5KoDPX43756B+FIwacYADxMPQxwP73/AAAAAElFTkSuQmCC
""")
TREE_IMG_3 = base64.decode("""
iVBORw0KGgoAAAANSUhEUgAAAAsAAAALCAYAAACprHcmAAAAAXNSR0IArs4c6QAAAIRJREFUKFNjZMACfNYH/N8SuIERXQpDAKQQpghdA4biOeob/m/oWABWj1cxsqlz84UZkie+RdGAYjKyYmxOgSvGphBdA4ZimPWbX25g8BUPQHE7WDHI1ICKBAaYx7AFJ8izcMUgBcimgUODt4XhZVI/3KMYQQdSVBnq8b999Q7CkYJPMQBqdkIMUVjCigAAAABJRU5ErkJggg==
""")

TREE_IMG_4 = base64.decode("""
iVBORw0KGgoAAAANSUhEUgAAAAsAAAALCAYAAACprHcmAAAAAXNSR0IArs4c6QAAAIlJREFUKFNjZMACfNYH/N8SuIERXQpDAKQQpghdA1bFW3hbGP7zhTAwmt1AkUfhIJuKzXQMxZulbzD4PtWAOxfZKXDFKG7lbWHw+VzDANMI04CieLPQdgbfd54Y4YOiGJtbQTpAHgXZAGYHbmAEmwxTjCyJbgtcMbq9laEe/9tX7yAcKSCNuBQDAG5kQwwkXuh1AAAAAElFTkSuQmCC
""")

DEFAULT_LOCATION = {
    "lat": 34.0522,
    "lng": -118.2437,
    "locality": "Los Angeles",
    "timezone": "US/Pacific",
}

FRIDAYTHE13TH_GREEN = "#1E792C"
FRIDAYTHE13TH_RED = "#C30F16"
FRIDAYTHE13TH_YES = "Yes!"
FRIDAYTHE13TH_NO = "No"

def main(config):
    location = config.get("location")
    loc = json.decode(location) if location else json.decode(str(DEFAULT_LOCATION))
    timezone = loc["timezone"]
    now = time.now().in_location(timezone)
    day = now.day
    day_of_week = time.now().format("Mon")
    is_friday_the_13th = FRIDAYTHE13TH_NO

    if day == 13 and day_of_week == "Fri":
        is_friday_the_13th = FRIDAYTHE13TH_YES
        
    print(is_friday_the_13th)

    return render.Root(
        delay = 500,
        child = render.Column(
            expanded = True,
            children = [
                render.Box(
                    height = 8,
                    child = render.Text("Is it", font = "tb-8", color = FRIDAYTHE13TH_GREEN),
                ),
                render.Box(
                    height = 8,
                    child = render.Text("Friday the 13th?", font = "tb-8", color = FRIDAYTHE13TH_GREEN),
                ),
                render.Box(
                    height = 4,
                ),
                render.Row(
                    expanded = True,
                    main_align = "space_between",
                    children = [
                        render.Animation(
                            children = get_tree_frames(is_friday_the_13th),
                        ),
                        render.Box(
                            height = 15,
                            width = 42,
                            child = is_friday_the_13th_text(is_friday_the_13th),
                        ),
                        render.Animation(
                            children = get_tree_frames(is_friday_the_13th),
                        ),
                    ],
                ),
            ],
        ),
    )

def is_friday_the_13th_text(is_friday_the_13th):
    color = FRIDAYTHE13TH_RED
    if is_friday_the_13th == FRIDAYTHE13TH_YES:
        color = FRIDAYTHE13TH_GREEN
    return render.Text(is_friday_the_13th, color = color)

def get_tree_frames(is_friday_the_13th):
    if is_friday_the_13th == FRIDAYTHE13TH_YES:
        return [
            render.Image(
                src = TREE_IMG_1,
                width = 11,
                height = 12,
            ),
            render.Image(
                src = TREE_IMG_2,
                width = 11,
                height = 12,
            ),
            render.Image(
                src = TREE_IMG_3,
                width = 11,
                height = 12,
            ),
            render.Image(
                src = TREE_IMG_4,
                width = 11,
                height = 12,
            ),
        ]
    else:
        return [
            render.Image(
                src = TREE_IMG_NO_LIGHTS,
                width = 11,
                height = 12,
            ),
        ]