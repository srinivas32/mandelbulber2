/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Box Fold VaryV1. Varies folding limit based on iteration conditions
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

#ifndef DOUBLE_PRECISION
float4 TransfBoxFoldVaryV1Iteration(float4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	float limit = fractal->mandelbox.foldingLimit;
	// float value = 2.0f *fractal->mandelbox.foldingLimit;
	float tempVC = limit; // constant to be varied

	if (aux->i >= fractal->transformCommon.startIterations250
			&& aux->i < fractal->transformCommon.stopIterations
			&& (fractal->transformCommon.stopIterations - fractal->transformCommon.startIterations250
					 != 0))
	{

		int iterationRange =
			fractal->transformCommon.stopIterations - fractal->transformCommon.startIterations250;
		int currentIteration = (aux->i - fractal->transformCommon.startIterations250);
		tempVC +=
			fractal->transformCommon.offset0 * native_divide((1.0f * currentIteration), iterationRange);
	}
	if (aux->i >= fractal->transformCommon.stopIterations)
	{
		tempVC = (tempVC + fractal->transformCommon.offset);
	}

	limit = tempVC;
	float value = fractal->transformCommon.scale2 * limit;

	if (z.x > limit)
	{
		z.x = value - z.x;
		aux->color += fractal->mandelbox.color.factor.x;
	}
	else if (z.x < -limit)
	{
		z.x = -value - z.x;
		aux->color += fractal->mandelbox.color.factor.x;
	}
	if (z.y > limit)
	{
		z.y = value - z.y;
		aux->color += fractal->mandelbox.color.factor.y;
	}
	else if (z.y < -limit)
	{
		z.y = -value - z.y;
		aux->color += fractal->mandelbox.color.factor.y;
	}
	float zLimit = limit * fractal->transformCommon.scale1;
	float zValue = value * fractal->transformCommon.scale1;
	if (z.z > zLimit)
	{
		z.z = zValue - z.z;
		aux->color += fractal->mandelbox.color.factor.z;
	}
	else if (z.z < -zLimit)
	{
		z.z = -zValue - z.z;
		aux->color += fractal->mandelbox.color.factor.z;
	}
	aux->DE *= fractal->analyticDE.scale1;
	return z;
}
#else
double4 TransfBoxFoldVaryV1Iteration(double4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	double limit = fractal->mandelbox.foldingLimit;
	// double value = 2.0 *fractal->mandelbox.foldingLimit;
	double tempVC = limit; // constant to be varied

	if (aux->i >= fractal->transformCommon.startIterations250
			&& aux->i < fractal->transformCommon.stopIterations
			&& (fractal->transformCommon.stopIterations - fractal->transformCommon.startIterations250
					 != 0))
	{

		int iterationRange =
			fractal->transformCommon.stopIterations - fractal->transformCommon.startIterations250;
		int currentIteration = (aux->i - fractal->transformCommon.startIterations250);
		tempVC +=
			fractal->transformCommon.offset0 * native_divide((1.0 * currentIteration), iterationRange);
	}
	if (aux->i >= fractal->transformCommon.stopIterations)
	{
		tempVC = (tempVC + fractal->transformCommon.offset);
	}

	limit = tempVC;
	double value = fractal->transformCommon.scale2 * limit;

	if (z.x > limit)
	{
		z.x = value - z.x;
		aux->color += fractal->mandelbox.color.factor.x;
	}
	else if (z.x < -limit)
	{
		z.x = -value - z.x;
		aux->color += fractal->mandelbox.color.factor.x;
	}
	if (z.y > limit)
	{
		z.y = value - z.y;
		aux->color += fractal->mandelbox.color.factor.y;
	}
	else if (z.y < -limit)
	{
		z.y = -value - z.y;
		aux->color += fractal->mandelbox.color.factor.y;
	}
	double zLimit = limit * fractal->transformCommon.scale1;
	double zValue = value * fractal->transformCommon.scale1;
	if (z.z > zLimit)
	{
		z.z = zValue - z.z;
		aux->color += fractal->mandelbox.color.factor.z;
	}
	else if (z.z < -zLimit)
	{
		z.z = -zValue - z.z;
		aux->color += fractal->mandelbox.color.factor.z;
	}
	aux->DE *= fractal->analyticDE.scale1;
	return z;
}
#endif
