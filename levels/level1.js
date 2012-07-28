{
    "settings": {
        "balls_needed": 3,
        "tools": ["MOVE"],
        "seed": "3224234"
    },
    "intro": [
        "Welcome to Blue Balls Inc! Formerly the number one exporter of blue balls in the whole of America. Unfortunately the place isn't what it used to be...",
        "We need you to restore this company to its former glory.",
        "Why not get started by sorting out this room. You just need to transport the ball from that hole into that other hole.",
        "I know it's not the highest tech operation in the world, but we try our best!",
        "Good luck"
    ],
    "walls": ["top", "left", "bottom", "right"],
    "entities": [
        {
            "type": "box",
            "x": 5.436797674218216,
            "y": 18.685786389480416,
            "angle": -12.565664850563655
        },
        {
            "type": "box",
            "x": 16.001418532698857,
            "y": 5.8159999260488915,
            "angle": 14.137691679752665
        },

        {
            "type": "box",
            "x": 15.990921200980313,
            "y": 9.445408506751189,
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
            "x": 16.5,
            "y": 15
        },
        {
            "type": "image",
            "image": "enter.png",
            "top": true,
            "x": 17,
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