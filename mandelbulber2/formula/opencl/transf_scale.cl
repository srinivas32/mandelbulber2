/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * scale - simple scale
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

#ifndef DOUBLE_PRECISION
float4 TransfScaleIteration(float4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	z *= fractal->transformCommon.scale;
	aux->DE = mad(aux->DE, fabs(fractal->transformCommon.scale), 1.0f);
	aux->r_dz *= fabs(fractal->transformCommon.scale);
	return z;
}
#else
double4 TransfScaleIteration(double4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	z *= fractal->transformCommon.scale;
	aux->DE = aux->DE * fabs(fractal->transformCommon.scale) + 1.0;
	aux->r_dz *= fabs(fractal->transformCommon.scale);
	return z;
}
#endif
