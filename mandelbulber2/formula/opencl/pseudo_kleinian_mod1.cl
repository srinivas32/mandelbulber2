/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Pseudo Kleinian Mod1, Knighty - Theli-at's Pseudo Kleinian (Scale 1 JuliaBox + Something
 * @reference https://github.com/Syntopia/Fragmentarium/blob/master/
 * Fragmentarium-Source/Examples/Knighty%20Collection/PseudoKleinian.frag
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

#ifndef DOUBLE_PRECISION
float4 PseudoKleinianMod1Iteration(float4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	float4 gap = fractal->transformCommon.constantMultiplier000;

	if (fractal->transformCommon.functionEnabledPFalse
			&& aux->i >= fractal->transformCommon.startIterationsP
			&& aux->i < fractal->transformCommon.stopIterationsP1)
	{
		z.y = fabs(z.y);
		z.z = fabs(z.z);
		float dot1 = (mad(z.x, -SQRT_3_4, z.y * 0.5f)) * fractal->transformCommon.scale;
		float t = max(0.0f, dot1);
		z.x -= t * -SQRT_3;
		z.y = fabs(z.y - t);

		if (z.y > z.z)
		{
			float temp = z.y;
			z.y = z.z;
			z.z = temp;
		}
		z -= gap * (float4){SQRT_3_4, 1.5f, 1.5f, 0.0f};
		// z was pos, now some points neg (ie neg shift)
		if (z.z > z.x)
		{
			float temp = z.z;
			z.z = z.x;
			z.x = temp;
		}
		if (z.x > 0.0f)
		{
			z.y = max(0.0f, z.y);
			z.z = max(0.0f, z.z);
		}
	}

	if (fractal->transformCommon.functionEnabledRFalse
			&& aux->i >= fractal->transformCommon.startIterationsR
			&& aux->i < fractal->transformCommon.stopIterationsR)
		z = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix, z);

	if (fractal->transformCommon.benesiT1EnabledFalse
			&& aux->i >= fractal->transformCommon.startIterations
			&& aux->i < fractal->transformCommon.stopIterationsT1)
	{
		float tempXZ = mad(z.x, SQRT_2_3, -z.z * SQRT_1_3);
		z = (float4){
			(tempXZ - z.y) * SQRT_1_2, (tempXZ + z.y) * SQRT_1_2, z.x * SQRT_1_3 + z.z * SQRT_2_3, z.w};

		float4 tempZ = z;
		float tempL = length(tempZ);
		z = fabs(z) * fractal->transformCommon.scale3D222;
		// if (tempL < 1e-21f) tempL = 1e-21f;
		float avgScale = native_divide(length(z), tempL);
		aux->r_dz *= avgScale;
		aux->DE = mad(aux->DE, avgScale, 1.0f);

		tempXZ = (z.y + z.x) * SQRT_1_2;

		z = (float4){z.z * SQRT_1_3 + tempXZ * SQRT_2_3, (z.y - z.x) * SQRT_1_2,
			z.z * SQRT_2_3 - tempXZ * SQRT_1_3, z.w};
		z = z - fractal->transformCommon.offset200;
	}

	if (fractal->transformCommon.functionEnabledxFalse
			&& aux->i >= fractal->transformCommon.startIterationsD
			&& aux->i < fractal->transformCommon.stopIterationsTM1)
	{
		float tempXZ = mad(z.x, SQRT_2_3, -z.z * SQRT_1_3);
		z = (float4){
			(tempXZ - z.y) * SQRT_1_2, (tempXZ + z.y) * SQRT_1_2, z.x * SQRT_1_3 + z.z * SQRT_2_3, z.w};

		float4 temp = z;
		float tempL = length(temp);
		z = fabs(z) * fractal->transformCommon.scale3D333;
		// if (tempL < 1e-21f) tempL = 1e-21f;
		float avgScale = native_divide(length(z), tempL);
		aux->r_dz *= avgScale;
		aux->DE = mad(aux->DE, avgScale, 1.0f);

		z = (fabs(z + fractal->transformCommon.additionConstant111)
				 - fabs(z - fractal->transformCommon.additionConstant111) - z);

		tempXZ = (z.y + z.x) * SQRT_1_2;

		z = (float4){z.z * SQRT_1_3 + tempXZ * SQRT_2_3, (z.y - z.x) * SQRT_1_2,
			z.z * SQRT_2_3 - tempXZ * SQRT_1_3, z.w};
	}
	if (fractal->transformCommon.functionEnabledFFalse
			&& aux->i >= fractal->transformCommon.startIterationsF
			&& aux->i < fractal->transformCommon.stopIterationsF)
	{
		float4 tempA, tempB;

		if (fractal->transformCommon.functionEnabledAx)
			tempA.x = fabs(z.x + fractal->transformCommon.offsetF000.x);

		if (fractal->transformCommon.functionEnabledx)
			tempB.x = fabs(z.x - fractal->transformCommon.offset000.x);

		z.x = tempA.x - tempB.x - (z.x * fractal->transformCommon.scale3D111.x);

		if (fractal->transformCommon.functionEnabledAy)
			tempA.y = fabs(z.y + fractal->transformCommon.offsetF000.y);

		if (fractal->transformCommon.functionEnabledy)
			tempB.y = fabs(z.y - fractal->transformCommon.offset000.y);

		z.y = tempA.y - tempB.y - (z.y * fractal->transformCommon.scale3D111.y);

		if (fractal->transformCommon.functionEnabledAz)
			tempA.z = fabs(z.z + fractal->transformCommon.offsetF000.z);

		if (fractal->transformCommon.functionEnabledz)
			tempB.z = fabs(z.z - fractal->transformCommon.offset000.z);

		z.z = tempA.z - tempB.z - (z.z * fractal->transformCommon.scale3D111.z);

		z += fractal->transformCommon.offsetA000;
	}

	float k;
	// Pseudo kleinian
	float4 cSize = fractal->transformCommon.additionConstant0777;
	if (fractal->transformCommon.functionEnabledAy
			&& aux->i >= fractal->transformCommon.startIterationsC
			&& aux->i < fractal->transformCommon.stopIterationsC)
	{
		float4 tempZ = z; //  correct c++ version. non conditional mult 2.0f

		if (z.x > cSize.x) tempZ.x = cSize.x;
		if (z.x < -cSize.x) tempZ.x = -cSize.x;
		if (z.y > cSize.y) tempZ.y = cSize.y;
		if (z.y < -cSize.y) tempZ.y = -cSize.y;
		if (z.z > cSize.z) tempZ.z = cSize.z;
		if (z.z < -cSize.z) tempZ.z = -cSize.z;

		z.z *= fractal->transformCommon.scaleB1;
		aux->DE *= fractal->transformCommon.scaleB1;

		z = mad(tempZ, 2.0f, -z);
		k = max(native_divide(fractal->transformCommon.minR05, dot(z, z)), 1.0f);
		z *= k;
		aux->DE *= k + fractal->analyticDE.tweak005;
	}

	if (fractal->transformCommon.functionEnabledAyFalse
			&& aux->i >= fractal->transformCommon.startIterationsB
			&& aux->i < fractal->transformCommon.stopIterationsB)
	{
		//  variation from openCL conditional mult 2.0f
		if (z.x > cSize.x) z.x = mad(cSize.x, 2.0f, -z.x);
		if (z.x < -cSize.x) z.x = mad(-cSize.x, 2.0f, -z.x);
		if (z.y > cSize.y) z.y = mad(cSize.y, 2.0f, -z.y);
		if (z.y < -cSize.y) z.y = mad(-cSize.y, 2.0f, -z.y);
		if (z.z > cSize.z) z.z = mad(cSize.z, 2.0f, -z.z);
		if (z.z < -cSize.z) z.z = mad(-cSize.z, 2.0f, -z.z);

		k = max(native_divide(fractal->transformCommon.minR05, dot(z, z)), 1.0f);
		z *= k;
		aux->DE *= k + fractal->analyticDE.tweak005;
	}

	z += fractal->transformCommon.additionConstant000;

	if (fractal->transformCommon.functionEnabledMFalse
			&& aux->i >= fractal->transformCommon.startIterationsM
			&& aux->i < fractal->transformCommon.stopIterationsM)
	{
		z = fabs(z);
		if (z.x - z.y < 0.0f)
		{
			float temp = z.y;
			z.y = z.x;
			z.x = temp;
		}
		if (z.x - z.z < 0.0f)
		{
			float temp = z.z;
			z.z = z.x;
			z.x = temp;
		}
		if (z.y - z.z < 0.0f)
		{
			float temp = z.z;
			z.z = z.y;
			z.y = temp;
		}
		z *= fractal->transformCommon.scale3;
		z.x -= 2.0f * fractal->transformCommon.constantMultiplierA111.x;
		z.y -= 2.0f * fractal->transformCommon.constantMultiplierA111.y;
		if (z.z > 1.0f) z.z -= 2.0f * fractal->transformCommon.constantMultiplierA111.z;
		aux->DE *= fractal->transformCommon.scale3 * fractal->transformCommon.scaleA1;

		z += fractal->transformCommon.additionConstantA000;
	}
	aux->pseudoKleinianDE = fractal->analyticDE.scale1; // pK DE
	return z;
}
#else
double4 PseudoKleinianMod1Iteration(double4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	double4 gap = fractal->transformCommon.constantMultiplier000;

	if (fractal->transformCommon.functionEnabledPFalse
			&& aux->i >= fractal->transformCommon.startIterationsP
			&& aux->i < fractal->transformCommon.stopIterationsP1)
	{
		z.y = fabs(z.y);
		z.z = fabs(z.z);
		double dot1 = (z.x * -SQRT_3_4 + z.y * 0.5) * fractal->transformCommon.scale;
		double t = max(0.0, dot1);
		z.x -= t * -SQRT_3;
		z.y = fabs(z.y - t);

		if (z.y > z.z)
		{
			double temp = z.y;
			z.y = z.z;
			z.z = temp;
		}
		z -= gap * (double4){SQRT_3_4, 1.5, 1.5, 0.0};
		// z was pos, now some points neg (ie neg shift)
		if (z.z > z.x)
		{
			double temp = z.z;
			z.z = z.x;
			z.x = temp;
		}
		if (z.x > 0.0)
		{
			z.y = max(0.0, z.y);
			z.z = max(0.0, z.z);
		}
	}

	if (fractal->transformCommon.functionEnabledRFalse
			&& aux->i >= fractal->transformCommon.startIterationsR
			&& aux->i < fractal->transformCommon.stopIterationsR)
		z = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix, z);

	if (fractal->transformCommon.benesiT1EnabledFalse
			&& aux->i >= fractal->transformCommon.startIterations
			&& aux->i < fractal->transformCommon.stopIterationsT1)
	{
		double tempXZ = mad(z.x, SQRT_2_3, -z.z * SQRT_1_3);
		z = (double4){
			(tempXZ - z.y) * SQRT_1_2, (tempXZ + z.y) * SQRT_1_2, z.x * SQRT_1_3 + z.z * SQRT_2_3, z.w};

		double4 tempZ = z;
		double tempL = length(tempZ);
		z = fabs(z) * fractal->transformCommon.scale3D222;
		// if (tempL < 1e-21) tempL = 1e-21;
		double avgScale = native_divide(length(z), tempL);
		aux->r_dz *= avgScale;
		aux->DE = aux->DE * avgScale + 1.0;

		tempXZ = (z.y + z.x) * SQRT_1_2;

		z = (double4){z.z * SQRT_1_3 + tempXZ * SQRT_2_3, (z.y - z.x) * SQRT_1_2,
			z.z * SQRT_2_3 - tempXZ * SQRT_1_3, z.w};
		z = z - fractal->transformCommon.offset200;
	}

	if (fractal->transformCommon.functionEnabledxFalse
			&& aux->i >= fractal->transformCommon.startIterationsD
			&& aux->i < fractal->transformCommon.stopIterationsTM1)
	{
		double tempXZ = mad(z.x, SQRT_2_3, -z.z * SQRT_1_3);
		z = (double4){
			(tempXZ - z.y) * SQRT_1_2, (tempXZ + z.y) * SQRT_1_2, z.x * SQRT_1_3 + z.z * SQRT_2_3, z.w};

		double4 temp = z;
		double tempL = length(temp);
		z = fabs(z) * fractal->transformCommon.scale3D333;
		// if (tempL < 1e-21) tempL = 1e-21;
		double avgScale = native_divide(length(z), tempL);
		aux->r_dz *= avgScale;
		aux->DE = aux->DE * avgScale + 1.0;

		z = (fabs(z + fractal->transformCommon.additionConstant111)
				 - fabs(z - fractal->transformCommon.additionConstant111) - z);

		tempXZ = (z.y + z.x) * SQRT_1_2;

		z = (double4){z.z * SQRT_1_3 + tempXZ * SQRT_2_3, (z.y - z.x) * SQRT_1_2,
			z.z * SQRT_2_3 - tempXZ * SQRT_1_3, z.w};
	}
	if (fractal->transformCommon.functionEnabledFFalse
			&& aux->i >= fractal->transformCommon.startIterationsF
			&& aux->i < fractal->transformCommon.stopIterationsF)
	{
		double4 tempA, tempB;

		if (fractal->transformCommon.functionEnabledAx)
			tempA.x = fabs(z.x + fractal->transformCommon.offsetF000.x);

		if (fractal->transformCommon.functionEnabledx)
			tempB.x = fabs(z.x - fractal->transformCommon.offset000.x);

		z.x = tempA.x - tempB.x - (z.x * fractal->transformCommon.scale3D111.x);

		if (fractal->transformCommon.functionEnabledAy)
			tempA.y = fabs(z.y + fractal->transformCommon.offsetF000.y);

		if (fractal->transformCommon.functionEnabledy)
			tempB.y = fabs(z.y - fractal->transformCommon.offset000.y);

		z.y = tempA.y - tempB.y - (z.y * fractal->transformCommon.scale3D111.y);

		if (fractal->transformCommon.functionEnabledAz)
			tempA.z = fabs(z.z + fractal->transformCommon.offsetF000.z);

		if (fractal->transformCommon.functionEnabledz)
			tempB.z = fabs(z.z - fractal->transformCommon.offset000.z);

		z.z = tempA.z - tempB.z - (z.z * fractal->transformCommon.scale3D111.z);

		z += fractal->transformCommon.offsetA000;
	}

	double k;
	// Pseudo kleinian
	double4 cSize = fractal->transformCommon.additionConstant0777;
	if (fractal->transformCommon.functionEnabledAy
			&& aux->i >= fractal->transformCommon.startIterationsC
			&& aux->i < fractal->transformCommon.stopIterationsC)
	{
		double4 tempZ = z; //  correct c++ version. non conditional mult 2.0

		if (z.x > cSize.x) tempZ.x = cSize.x;
		if (z.x < -cSize.x) tempZ.x = -cSize.x;
		if (z.y > cSize.y) tempZ.y = cSize.y;
		if (z.y < -cSize.y) tempZ.y = -cSize.y;
		if (z.z > cSize.z) tempZ.z = cSize.z;
		if (z.z < -cSize.z) tempZ.z = -cSize.z;

		z.z *= fractal->transformCommon.scaleB1;
		aux->DE *= fractal->transformCommon.scaleB1;

		z = tempZ * 2.0 - z;
		k = max(native_divide(fractal->transformCommon.minR05, dot(z, z)), 1.0);
		z *= k;
		aux->DE *= k + fractal->analyticDE.tweak005;
	}

	if (fractal->transformCommon.functionEnabledAyFalse
			&& aux->i >= fractal->transformCommon.startIterationsB
			&& aux->i < fractal->transformCommon.stopIterationsB)
	{
		//  variation from openCL conditional mult 2.0
		if (z.x > cSize.x) z.x = cSize.x * 2.0 - z.x;
		if (z.x < -cSize.x) z.x = -cSize.x * 2.0 - z.x;
		if (z.y > cSize.y) z.y = cSize.y * 2.0 - z.y;
		if (z.y < -cSize.y) z.y = -cSize.y * 2.0 - z.y;
		if (z.z > cSize.z) z.z = cSize.z * 2.0 - z.z;
		if (z.z < -cSize.z) z.z = -cSize.z * 2.0 - z.z;

		k = max(native_divide(fractal->transformCommon.minR05, dot(z, z)), 1.0);
		z *= k;
		aux->DE *= k + fractal->analyticDE.tweak005;
	}

	z += fractal->transformCommon.additionConstant000;

	if (fractal->transformCommon.functionEnabledMFalse
			&& aux->i >= fractal->transformCommon.startIterationsM
			&& aux->i < fractal->transformCommon.stopIterationsM)
	{
		z = fabs(z);
		if (z.x - z.y < 0.0)
		{
			double temp = z.y;
			z.y = z.x;
			z.x = temp;
		}
		if (z.x - z.z < 0.0)
		{
			double temp = z.z;
			z.z = z.x;
			z.x = temp;
		}
		if (z.y - z.z < 0.0)
		{
			double temp = z.z;
			z.z = z.y;
			z.y = temp;
		}
		z *= fractal->transformCommon.scale3;
		z.x -= 2.0 * fractal->transformCommon.constantMultiplierA111.x;
		z.y -= 2.0 * fractal->transformCommon.constantMultiplierA111.y;
		if (z.z > 1.0) z.z -= 2.0 * fractal->transformCommon.constantMultiplierA111.z;
		aux->DE *= fractal->transformCommon.scale3 * fractal->transformCommon.scaleA1;

		z += fractal->transformCommon.additionConstantA000;
	}
	aux->pseudoKleinianDE = fractal->analyticDE.scale1; // pK DE
	return z;
}
#endif
