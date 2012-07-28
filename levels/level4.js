{
    "settings": {
        "balls_needed": 3,
        "tools": ["MOVE"],
        "seed": "4354364564"
    },
    "intro": [
        "Those idiots! They've messed up the order. They've mixed a load of metal in with the blue balls! Who even buys metal balls?",
        "You need to get the metal balls out of the production line",
        "Maybe this will help"
    ],
    "walls": ["top", "left", "bottom", "right"],
    "entities": [
        {
            "type": "magnet",
            "x": 16.6,
            "y": 18
        },
        {
            "type": "box",
            "x": 16.6,
            "y": 18
        },
        {
            "type": "plank",
            "x": 14,
            "y": 14
        },
        {
            "type": "peg",
            "x": 12,
            "y": 5
        },
        {
            "type": "peg",
            "x": 16,
            "y": 5
        },
        {
            "type": "peg",
            "x": 20,
            "y": 5
        },
        {
            "type": "ledge",
            "x": 7,
            "y": 14,
            "angle": 0.2,
            "fixed": true
        },
        {
            "type": "enter_dropper",
            "x": 5.5,
            "y": 0.4,
            "maximum_balls": 6,
            "ball_order": ["ball", "metal-ball"]
        },
        {
            "type": "exit",
            "image": "in.png",
            "x": 19.5,
            "y": 15
        },
        {
            "type": "image",
            "image": "enter.png",
            "top": true,
            "x": 20,
            "y": 15,
            "angle": 4.7,
            "bodies": [
                {
                    "shape": {
                        "type": "rectangle",
                        "size": {
                            "width": 0.1,
                            "height": 0.1
                        },
                        "position": {
                            "angle": 90
                        }
                    }
                },
                {
                    "shape": {
                        "type": "rectangle",
                        "size": {
                            "width": 0.1,
                            "height": 1.1
                        }
                    },
                    "position": {
                        "x": -1.1,
                        "y": 0.1
                    }
                },
                {
                    "shape": {
                        "type": "rectangle",
                        "size": {
                            "width": 0.1,
                            "height": 1.1
                        }
                    },
                    "position": {
                        "x": 1.1,
                        "y": 0.1
                    }
                },
                {
                    "shape": {
                        "type": "rectangle",
                        "size": {
                            "width": 1,
                            "height": 0.1
                        }
                    },
                    "position": {
                        "x": 0,
                        "y": 1.3
                    }
                }
            ]
        },
        {
            "type": "image",
            "image": "exit.png",
            "top": true,
            "x": 5.5,
            "y": 0.4,
            "bodies": [
                {
                    "shape": {
                        "type": "rectangle",
                        "size": {
                            "width": 0.1,
                            "height": 0.1
                        }
                    }
                },
                {
                    "shape": {
                        "type": "rectangle",
                        "size": {
                            "width": 0.1,
                            "height": 1.3
                        }
                    },
                    "position": {
                        "x": -1.2,
                        "y": 0
                    }
                },
                {
                    "shape": {
                        "type": "rectangle",
                        "size": {
                            "width": 0.1,
                            "height": 1.3
                        }
                    },
                    "position": {
                        "x": 1.2,
                        "y": 0
                    }
                }
            ]
        }
    ]
}