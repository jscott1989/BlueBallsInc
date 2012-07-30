{
    "settings": {
        "balls_needed": 3,
        "tools": ["MOVE"],
        "seed": "1234567899"
    },
    "intro": [
        "This one is pretty good. Maybe. Go for it."
    ],
    "walls": [],
    "entities": [
        {
            "type": "ledge",
            "x": 7,
            "y": 14,
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
            "x": 17,
            "y": 14
        },
        {
            "type": "image",
            "image": "enter.png",
            "top": true,
            "x": 17,
            "y": 14,
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
        },
        {
            "type": "wheel",
            "x": 17.436797674218216,
            "y": 18.685786389480416,
            "angle": -12.565664850563655
        },
        {
            "type": "plank",
            "x": 16.001418532698857,
            "y": 5.8159999260488915,
            "angle": 14.137691679752665
        },
        {
            "type": "plank",
            "x": 5.001418532698857,
            "y": 5.8159999260488915,
            "angle": 14.137691679752665
        },
        {
            "type": "box",
            "x": 14.697277066805388,
            "y": 18.685980267345847,
            "angle": -14.135214968379996
        },
        {
            "type": "ywall",
            "x": 0,
            "y": 10,
            "glue": [],
            "id": "entity_25",
            "angle": 0
        },
        {
            "type": "xwall",
            "x": 11.5,
            "y": 0,
            "angle": 0
        },
        {
            "type": "ywall",
            "x": 23.199999999999996,
            "y": 9.9999999999999929,
            "angle": 0
        },
        {
            "type": "xwall",
            "x": 11.500000000000007,
            "y": 19.999999999999986,
            "angle": 0
        }
    ]
}