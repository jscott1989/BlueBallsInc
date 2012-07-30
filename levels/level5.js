{
    "settings": {
        "balls_needed": 3,
        "tools": ["MOVE"],
        "seed": "3224234"
    },
    "intro": [
        "I had big plans for this (poorly designed) trampoline. *sigh*"
    ],
    "walls": ["top", "left", "bottom", "right"],
    "entities": [
        {
            "type": "peg",
            "x": 12,
            "y": 5
        },
        {
            "type": "trampoline",
            "x": 12,
            "y": 5
        },
        {
            "type": "peg",
            "x": 20,
            "y": 5
        },
        {
            "type": "ledge",
            "x": 4,
            "y": 13,
            "angle": 0.2,
            "fixed": true
        },
        {
            "type": "ledge",
            "x": 21.5,
            "y": 15,
            "fixed": true
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
            "x": 20,
            "y": 13.5
        },
        {
            "type": "image",
            "image": "enter.png",
            "top": true,
            "x": 20,
            "y": 13.5,
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