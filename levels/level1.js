{
    "settings": {
        "balls_needed": 3,
        "tools": ["MOVE", "GLUE"]
    },
    "walls": [],
    "entities": [
        {
            "scale": 0.5,
            "components": [
                "gluable",
                "enter_dropper"
            ],
            "name": "Ball Dropper",
            "width_scale": 2,
            "height_scale": 2,
            "fixed": true,
            "scale_adjustment": 1,
            "physics": {
                "density": 40,
                "friction": 2,
                "restitution": 0.20000000000000001,
                "shape": {
                    "type": "rectangle",
                    "size": {
                        "width": 1,
                        "height": 1
                    }
                }
            },
            "type": "enter_dropper",
            "x": 5.5,
            "y": 1,
            "glue": [],
            "ball_creation_interval": 500,
            "id": "entity_15",
            "angle": 0,
            "maximum_balls": 3
        },
        {
            "scale": 1,
            "components": [
                "gluable"
            ],
            "name": "Exit",
            "fixed": true,
            "physics": {
                "density": 40,
                "friction": 2,
                "restitution": 0.20000000000000001,
                "shape": {
                    "type": "rectangle",
                    "size": {
                        "width": 1.2000000000000002,
                        "height": 1.2000000000000002
                    }
                }
            },
            "type": "exit_box",
            "x": 17,
            "y": 14,
            "glue": [],
            "id": "entity_16",
            "angle": 11
        },

        {
            "scale": 1,
            "components": [
                "gluable"
            ],
            "name": "Box",
            "width_scale": 6,
            "height_scale": 6,
            "scale_adjustment": 0.20000000000000001,
            "physics": {
                "density": 40,
                "friction": 2,
                "restitution": 0.20000000000000001,
                "shape": {
                    "type": "rectangle",
                    "size": {
                        "width": 1.2000000000000002,
                        "height": 1.2000000000000002
                    }
                }
            },
            "type": "box",
            "x": 3.2042364058183859,
            "y": 18.693433780075363,
            "glue": [],
            "id": "entity_18",
            "angle": -0.0013778974700028692
        },

        {
            "scale": 1,
            "components": [
                "gluable"
            ],
            "name": "Box",
            "width_scale": 6,
            "height_scale": 6,
            "scale_adjustment": 0.20000000000000001,
            "physics": {
                "density": 40,
                "friction": 2,
                "restitution": 0.20000000000000001,
                "shape": {
                    "type": "rectangle",
                    "size": {
                        "width": 1.2000000000000002,
                        "height": 1.2000000000000002
                    }
                }
            },
            "type": "box",
            "x": 10.23910251813551,
            "y": 16.676224119548134,
            "glue": [],
            "id": "entity_20",
            "angle": -0.66722544795165573
        },

        {
            "scale": 1,
            "components": [
                "gluable"
            ],
            "name": "Box",
            "width_scale": 6,
            "height_scale": 6,
            "scale_adjustment": 0.20000000000000001,
            "physics": {
                "density": 40,
                "friction": 2,
                "restitution": 0.20000000000000001,
                "shape": {
                    "type": "rectangle",
                    "size": {
                        "width": 1.2000000000000002,
                        "height": 1.2000000000000002
                    }
                }
            },
            "type": "box",
            "x": 8.1428275692498069,
            "y": 18.693523480518476,
            "glue": [],
            "id": "entity_22",
            "angle": 0.0012311911289215709
        },
        {
            "scale": 1,
            "components": [
                "gluable"
            ],
            "name": "Box",
            "width_scale": 6,
            "height_scale": 6,
            "scale_adjustment": 0.20000000000000001,
            "physics": {
                "density": 40,
                "friction": 2,
                "restitution": 0.20000000000000001,
                "shape": {
                    "type": "rectangle",
                    "size": {
                        "width": 1.2000000000000002,
                        "height": 1.2000000000000002
                    }
                }
            },
            "type": "box",
            "x": 12.348507202697048,
            "y": 18.693631058705282,
            "glue": [],
            "id": "entity_23",
            "angle": -14.137921370726076
        },
        {
            "scale": 2,
            "components": [
                "gluable"
            ],
            "name": "Box",
            "width_scale": 6,
            "height_scale": 6,
            "scale_adjustment": 0.20000000000000001,
            "physics": {
                "density": 40,
                "friction": 2,
                "restitution": 0.20000000000000001,
                "shape": {
                    "type": "rectangle",
                    "size": {
                        "width": 2.4000000000000004,
                        "height": 2.4000000000000004
                    }
                }
            },
            "type": "box",
            "x": 2.5127884546211976,
            "y": 15.08927955679807,
            "glue": [],
            "id": "entity_24",
            "angle": 1.5689786758463644
        },
        {
            "scale": 1,
            "components": [
                "gluable"
            ],
            "name": "Wall",
            "fixed": true,
            "physics": {
                "shape": {
                    "type": "rectangle",
                    "size": {
                        "width": 0.10000000000000001,
                        "height": 10
                    }
                },
                "density": 0,
                "friction": 0.20000000000000001,
                "restitution": 0
            },
            "type": "ywall",
            "x": 0,
            "y": 10,
            "glue": [],
            "id": "entity_25",
            "angle": 0
        },
        {
            "scale": 1,
            "components": [
                "gluable"
            ],
            "name": "Wall",
            "fixed": true,
            "physics": {
                "shape": {
                    "type": "rectangle",
                    "size": {
                        "width": 11.5,
                        "height": 0.10000000000000001
                    }
                },
                "density": 0,
                "friction": 0.20000000000000001,
                "restitution": 0
            },
            "type": "xwall",
            "x": 11.5,
            "y": 0,
            "glue": [],
            "id": "entity_26",
            "angle": 0
        },
        {
            "scale": 1,
            "components": [
                "gluable"
            ],
            "name": "Wall",
            "fixed": true,
            "physics": {
                "shape": {
                    "type": "rectangle",
                    "size": {
                        "width": 0.10000000000000001,
                        "height": 10
                    }
                },
                "density": 0,
                "friction": 0.20000000000000001,
                "restitution": 0
            },
            "type": "ywall",
            "x": 23.199999999999996,
            "y": 9.9999999999999929,
            "glue": [],
            "id": "entity_27",
            "angle": 0
        },
        {
            "scale": 1,
            "components": [
                "gluable"
            ],
            "name": "Wall",
            "fixed": true,
            "physics": {
                "shape": {
                    "type": "rectangle",
                    "size": {
                        "width": 11.5,
                        "height": 0.10000000000000001
                    }
                },
                "density": 0,
                "friction": 0.20000000000000001,
                "restitution": 0
            },
            "type": "xwall",
            "x": 11.500000000000007,
            "y": 19.999999999999986,
            "glue": [],
            "id": "entity_28",
            "angle": 0
        }
    ]
}