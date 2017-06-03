/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Darkbeam's MixPinski4 from M3D
 * A strange but intriguing fractal, that mixes Sierpinski and Menger folds.
 * The amazing thing is that in 3D it does not work so well! LUCA GN 2011
 * @reference
 * http://www.fractalforums.com/mandelbulb-3d/custom-formulas-and-transforms-release-t17106/
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

#ifndef DOUBLE_PRECISION
float4 MixPinski4dIteration(float4 *z4D, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	if (aux->i >= fractal->transformCommon.startIterationsS
			&& aux->i < fractal->transformCommon.stopIterationsS)
	{
		float temp;
		if (z4D->x + z4D->y < 0.0f)
		{
			temp = z4D->x;
			z4D->x = -z4D->y;
			z4D->y = -temp;
		}

		if (z4D->x + z4D->z < 0.0f)
		{
			temp = z4D->x;
			z4D->x = -z4D->z;
			z4D->z = -temp;
		}

		if (z4D->y + z4D->z < 0.0f)
		{
			temp = z4D->z;
			z4D->z = -z4D->y;
			z4D->y = -temp;
		}

		if (z4D->x + z4D->w < 0.0f)
		{
			temp = z4D->x;
			z4D->x = -z4D->w;
			z4D->w = -temp;
		}

		if (z4D->y + z4D->w < 0.0f)
		{
			temp = z4D->y;
			z4D->y = -z4D->w;
			z4D->w = -temp;
		}

		if (z4D->z + z4D->w < 0.0f)
		{
			temp = z4D->z;
			z4D->z = -z4D->w;
			z4D->w = -temp;
		}
		*z4D *= fractal->transformCommon.scale1;
		aux->DE *= fractal->transformCommon.scale1;
	}

	if (aux->i >= fractal->transformCommon.startIterationsC
			&& aux->i < fractal->transformCommon.stopIterationsC)
	{
		*z4D += fractal->transformCommon.additionConstant0000; // offset
	}
	// 6 plane rotation
	if (fractal->transformCommon.functionEnabledRFalse
			&& aux->i >= fractal->transformCommon.startIterationsR
			&& aux->i < fractal->transformCommon.stopIterationsR)
	{
		float4 tp;
		if (fractal->transformCommon.rotation44a.x != 0)
		{
			tp = *z4D;
			float alpha = fractal->transformCommon.rotation44a.x * M_PI_180;
			z4D->x = mad(tp.x, native_cos(alpha), tp.y * native_sin(alpha));
			z4D->y = tp.x * -native_sin(alpha) + tp.y * native_cos(alpha);
		}
		if (fractal->transformCommon.rotation44a.y != 0)
		{
			tp = *z4D;
			float beta = fractal->transformCommon.rotation44a.y * M_PI_180;
			z4D->y = mad(tp.y, native_cos(beta), tp.z * native_sin(beta));
			z4D->z = tp.y * -native_sin(beta) + tp.z * native_cos(beta);
		}
		if (fractal->transformCommon.rotation44a.z != 0)
		{
			tp = *z4D;
			float gamma = fractal->transformCommon.rotation44a.z * M_PI_180;
			z4D->x = mad(tp.x, native_cos(gamma), tp.z * native_sin(gamma));
			z4D->z = tp.x * -native_sin(gamma) + tp.z * native_cos(gamma);
		}
		if (fractal->transformCommon.rotation44b.x != 0)
		{
			tp = *z4D;
			float delta = fractal->transformCommon.rotation44b.x * M_PI_180;
			z4D->x = mad(tp.x, native_cos(delta), tp.w * native_sin(delta));
			z4D->w = tp.x * -native_sin(delta) + tp.w * native_cos(delta);
		}
		if (fractal->transformCommon.rotation44b.y != 0)
		{
			tp = *z4D;
			float epsilon = fractal->transformCommon.rotation44b.y * M_PI_180;
			z4D->y = mad(tp.y, native_cos(epsilon), tp.w * native_sin(epsilon));
			z4D->w = tp.y * -native_sin(epsilon) + tp.w * native_cos(epsilon);
		}
		if (fractal->transformCommon.rotation44b.z != 0)
		{
			tp = *z4D;
			float zeta = fractal->transformCommon.rotation44b.z * M_PI_180;
			z4D->z = mad(tp.z, native_cos(zeta), tp.w * native_sin(zeta));
			z4D->w = tp.z * -native_sin(zeta) + tp.w * native_cos(zeta);
		}
	}
	if (aux->i >= fractal->transformCommon.startIterationsM
			&& aux->i < fractal->transformCommon.stopIterationsM)
	{
		float scaleM = fractal->transformCommon.scale2;
		float4 offsetM = fractal->transformCommon.additionConstant111d5;
		z4D->x = mad(scaleM, z4D->x, -offsetM.x * (scaleM - 1.0f));
		z4D->y = mad(scaleM, z4D->y, -offsetM.y * (scaleM - 1.0f));
		z4D->w = mad(scaleM, z4D->w, -offsetM.w * (scaleM - 1.0f));
		z4D->z -= 0.5f * offsetM.z * native_divide((scaleM - 1.0f), scaleM);
		z4D->z = -fabs(-z4D->z);
		z4D->z += 0.5f * offsetM.z * native_divide((scaleM - 1.0f), scaleM);
		z4D->z = scaleM * z4D->z;
		aux->DE *= scaleM * fractal->analyticDE.scale1;
	}
	return z;
}
#else
double4 MixPinski4dIteration(double4 *z4D, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	if (aux->i >= fractal->transformCommon.startIterationsS
			&& aux->i < fractal->transformCommon.stopIterationsS)
	{
		double temp;
		if (z4D->x + z4D->y < 0.0)
		{
			temp = z4D->x;
			z4D->x = -z4D->y;
			z4D->y = -temp;
		}

		if (z4D->x + z4D->z < 0.0)
		{
			temp = z4D->x;
			z4D->x = -z4D->z;
			z4D->z = -temp;
		}

		if (z4D->y + z4D->z < 0.0)
		{
			temp = z4D->z;
			z4D->z = -z4D->y;
			z4D->y = -temp;
		}

		if (z4D->x + z4D->w < 0.0)
		{
			temp = z4D->x;
			z4D->x = -z4D->w;
			z4D->w = -temp;
		}

		if (z4D->y + z4D->w < 0.0)
		{
			temp = z4D->y;
			z4D->y = -z4D->w;
			z4D->w = -temp;
		}

		if (z4D->z + z4D->w < 0.0)
		{
			temp = z4D->z;
			z4D->z = -z4D->w;
			z4D->w = -temp;
		}
		*z4D *= fractal->transformCommon.scale1;
		aux->DE *= fractal->transformCommon.scale1;
	}

	if (aux->i >= fractal->transformCommon.startIterationsC
			&& aux->i < fractal->transformCommon.stopIterationsC)
	{
		*z4D += fractal->transformCommon.additionConstant0000; // offset
	}
	// 6 plane rotation
	if (fractal->transformCommon.functionEnabledRFalse
			&& aux->i >= fractal->transformCommon.startIterationsR
			&& aux->i < fractal->transformCommon.stopIterationsR)
	{
		double4 tp;
		if (fractal->transformCommon.rotation44a.x != 0)
		{
			tp = *z4D;
			double alpha = fractal->transformCommon.rotation44a.x * M_PI_180;
			z4D->x = mad(tp.x, native_cos(alpha), tp.y * native_sin(alpha));
			z4D->y = tp.x * -native_sin(alpha) + tp.y * native_cos(alpha);
		}
		if (fractal->transformCommon.rotation44a.y != 0)
		{
			tp = *z4D;
			double beta = fractal->transformCommon.rotation44a.y * M_PI_180;
			z4D->y = mad(tp.y, native_cos(beta), tp.z * native_sin(beta));
			z4D->z = tp.y * -native_sin(beta) + tp.z * native_cos(beta);
		}
		if (fractal->transformCommon.rotation44a.z != 0)
		{
			tp = *z4D;
			double gamma = fractal->transformCommon.rotation44a.z * M_PI_180;
			z4D->x = mad(tp.x, native_cos(gamma), tp.z * native_sin(gamma));
			z4D->z = tp.x * -native_sin(gamma) + tp.z * native_cos(gamma);
		}
		if (fractal->transformCommon.rotation44b.x != 0)
		{
			tp = *z4D;
			double delta = fractal->transformCommon.rotation44b.x * M_PI_180;
			z4D->x = mad(tp.x, native_cos(delta), tp.w * native_sin(delta));
			z4D->w = tp.x * -native_sin(delta) + tp.w * native_cos(delta);
		}
		if (fractal->transformCommon.rotation44b.y != 0)
		{
			tp = *z4D;
			double epsilon = fractal->transformCommon.rotation44b.y * M_PI_180;
			z4D->y = mad(tp.y, native_cos(epsilon), tp.w * native_sin(epsilon));
			z4D->w = tp.y * -native_sin(epsilon) + tp.w * native_cos(epsilon);
		}
		if (fractal->transformCommon.rotation44b.z != 0)
		{
			tp = *z4D;
			double zeta = fractal->transformCommon.rotation44b.z * M_PI_180;
			z4D->z = mad(tp.z, native_cos(zeta), tp.w * native_sin(zeta));
			z4D->w = tp.z * -native_sin(zeta) + tp.w * native_cos(zeta);
		}
	}
	if (aux->i >= fractal->transformCommon.startIterationsM
			&& aux->i < fractal->transformCommon.stopIterationsM)
	{
		double scaleM = fractal->transformCommon.scale2;
		double4 offsetM = fractal->transformCommon.additionConstant111d5;
		z4D->x = mad(scaleM, z4D->x, -offsetM.x * (scaleM - 1.0));
		z4D->y = mad(scaleM, z4D->y, -offsetM.y * (scaleM - 1.0));
		z4D->w = mad(scaleM, z4D->w, -offsetM.w * (scaleM - 1.0));
		z4D->z -= 0.5 * offsetM.z * native_divide((scaleM - 1.0), scaleM);
		z4D->z = -fabs(-z4D->z);
		z4D->z += 0.5 * offsetM.z * native_divide((scaleM - 1.0), scaleM);
		z4D->z = scaleM * z4D->z;
		aux->DE *= scaleM * fractal->analyticDE.scale1;
	}
	return z;
}
#endif
