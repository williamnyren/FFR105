function acceleration = Acceleration(acceleration, mass, forceGravity, forceBraking, forceEngine)
    acceleration = (forceGravity - forceBraking - forceEngine)./mass;
end