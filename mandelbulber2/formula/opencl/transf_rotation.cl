/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * rotation
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

#ifndef DOUBLE_PRECISION
float4 TransfRotationIteration(float4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	Q_UNUSED(aux);

	z = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix, z);
	return z;
}
#else
double4 TransfRotationIteration(double4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	Q_UNUSED(aux);

	z = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix, z);
	return z;
}
#endif
