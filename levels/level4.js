{
    "settings": {
        "balls_needed": 3,
        "tools": ["MOVE"],
        "seed": "3224234"
    },
    "intro": [
        "Those idiots! They've messed up the order. They've mixed a load of metal in with the blue balls! Who even buys metal balls?",
        "You need to get the metal balls out of the production line",
        "Maybe this will help"
    ],
    "walls": ["top", "left", "bottom", "right"],
    "entities": [
        {
            "type": "box",
            "x": 3.6,
            "y": 14,
            "angle": 3.2
        },
        {
            "type": "plank",
            "x": 21,
            "y": 12,
            "angle": -0.7
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
            "y": 10,
            "angle": 0.2,
            "fixed": true
        },
        {
            "type": "magnet",
            "x": 3,
            "y": 5,
            "angle": 2.4
        },
        {
            "type": "wheel",
            "x": 18,
            "y": 18
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