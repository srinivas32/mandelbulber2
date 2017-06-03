/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * From M3D
 * @reference http://www.fractalforums.com/3d-fractal-generation/another-shot-at-the-holy-grail/
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

#ifndef DOUBLE_PRECISION
float4 QuickDudleyModIteration(float4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	Q_UNUSED(aux);

	float x2 = z.x * z.x;
	float y2 = z.y * z.y;
	float z2 = z.z * z.z;
	float newx = mad(x2, fractal->transformCommon.constantMultiplier111.x,
		-fractal->transformCommon.constantMultiplier222.x * z.y * z.z);
	float newy = mad(z2, fractal->transformCommon.constantMultiplier111.y,
		fractal->transformCommon.constantMultiplier222.y * z.x * z.y);
	float newz = mad(y2, fractal->transformCommon.constantMultiplier111.z,
		fractal->transformCommon.constantMultiplier222.z * z.z * z.x);
	z.x = newx;
	z.y = newy;
	z.z = newz;
	return z;
}
#else
double4 QuickDudleyModIteration(double4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	Q_UNUSED(aux);

	double x2 = z.x * z.x;
	double y2 = z.y * z.y;
	double z2 = z.z * z.z;
	double newx = mad(x2, fractal->transformCommon.constantMultiplier111.x,
		-fractal->transformCommon.constantMultiplier222.x * z.y * z.z);
	double newy = mad(z2, fractal->transformCommon.constantMultiplier111.y,
		fractal->transformCommon.constantMultiplier222.y * z.x * z.y);
	double newz = mad(y2, fractal->transformCommon.constantMultiplier111.z,
		fractal->transformCommon.constantMultiplier222.z * z.z * z.x);
	z.x = newx;
	z.y = newy;
	z.z = newz;
	return z;
}
#endif
