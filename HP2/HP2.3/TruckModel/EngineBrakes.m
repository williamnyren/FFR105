function forceEngine = EngineBrakes(cb, gear)
    forceEngineArray = cb*[ 7; 5; 4; 3; 2.5; 2; 1.6; 1.4; 1.2; 1];
    forceEngine = forceEngineArray(gear);
end