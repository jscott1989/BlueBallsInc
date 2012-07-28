{
    "settings": {
        "balls_needed": 3,
        "tools": ["MOVE"],
        "seed": "3224234"
    },
    "intro": [
        "This one is a little further out. I'm sure we used to have a conveyor belt to do this stuff",
        "Oh well, here's a stick - maybe you can do something with it",
        "Good luck"
    ],
    "walls": ["top", "left", "bottom", "right"],
    "entities": [
        {
            "type": "plank",
            "x": 10.6,
            "y": 5.685980267345847,
            "angle": 3.2
        },
        {
            "type": "box",
            "x": 5.436797674218216,
            "y": 18.685980267345847,
            "angle": -12.565664850563655
        },
        {
            "type": "box",
            "x": 15.001418532698857,
            "y": 18.685980267345847,
            "angle": 14.137691679752665
        },

        {
            "type": "box",
            "x": 14.990921200980313,
            "y": 18.685980267345847,
            "angle": 7.8544855969471135
        },
        {
            "type": "box",
            "x": 2.697277066805388,
            "y": 18.685980267345847,
            "angle": -14.135214968379996
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