import json


data : dict = {
    "action" : False,
    "opponentDirection" : 1.0,
    "opponentPositionX" : 0.0,
    "opponentPositionY" : 0.0,
    "opponentVelocityX" : 0.0,
    "opponentVelocityY" : 0.0,
    "positionX" : 0.0,
    "positionY" : 0.0,
    "velocityX" : 0.0,
    "velocityY" : 0.0
}


def getData() -> dict:
    """Returns a dictionary of the most recent accessable bot data."""
    global data
    dataFile = open("tempIn.json", "r")
    dataString = dataFile.read()
    if dataString != "":
        data = json.loads(dataString)
    dataFile.close()
    return data


def sendDir(dir : float) -> None:
    """Attempts to send input (direction) value to bot."""
    send = open("tempOut.json", "w")
    dirDictionary = {"direction" : dir}
    send.write(json.dumps(dirDictionary))
    send.close()