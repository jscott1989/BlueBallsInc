{
    "settings": {
        "balls_needed": 3,
        "tools": ["MOVE"],
        "seed": "3224234"
    },
    "intro": [
        "I have no idea where that wheel came from. This stuff definitely worked at one point though."
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
            "type": "wheel",
            "x": 3,
            "y": 5
        },
        {
            "type": "enter_dropper",
            "x": 5.5,
            "y": 0.4,
            "maximum_balls": 3
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