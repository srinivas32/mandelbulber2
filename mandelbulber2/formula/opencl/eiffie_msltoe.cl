/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * MsltoeJuliaBulb Eiffie. Refer post by Eiffie    Reply #69 on: January 27, 2015
 * @reference http://www.fractalforums.com/theory/choosing-the-squaring-formula-by-location/60/
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

#ifndef DOUBLE_PRECISION
float4 EiffieMsltoeIteration(float4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	float4 c = aux->const_c;
	float psi = fabs(fmod(atan2(z.z, z.y) + M_PI + M_PI_8, M_PI_4) - M_PI_8);
	float lengthYZ = native_sqrt(mad(z.y, z.y, z.z * z.z));

	z.y = native_cos(psi) * lengthYZ;
	z.z = native_sin(psi) * lengthYZ;
	aux->r_dz = aux->r_dz * 2.0f * aux->r;

	float4 z2 = z * z;
	float rr = z2.x + z2.y + z2.z;
	float m = 1.0f - native_divide(z2.z, rr);
	float4 temp;
	temp.x = (z2.x - z2.y) * m;
	temp.y = 2.0f * z.x * z.y * m * fractal->transformCommon.scale; // scaling y;;
	temp.z = 2.0f * z.z * native_sqrt(z2.x + z2.y);
	temp.w = z.w;
	z = temp + fractal->transformCommon.additionConstant000;

	if (fractal->transformCommon.addCpixelEnabledFalse)
	{
		float4 tempFAB = c;
		if (fractal->transformCommon.functionEnabledx) tempFAB.x = fabs(tempFAB.x);
		if (fractal->transformCommon.functionEnabledy) tempFAB.y = fabs(tempFAB.y);
		if (fractal->transformCommon.functionEnabledz) tempFAB.z = fabs(tempFAB.z);

		tempFAB *= fractal->transformCommon.constantMultiplier000;
		z.x += copysign(tempFAB.x, z.x);
		z.y += copysign(tempFAB.y, z.y);
		z.z += copysign(tempFAB.z, z.z);
	}
	float lengthTempZ = length(-z);
	// if (lengthTempZ > -1e-21f) lengthTempZ = -1e-21f;   //  z is neg.)
	z *= 1.0f + native_divide(fractal->transformCommon.offset, lengthTempZ);
	z *= fractal->transformCommon.scale1;
	aux->DE = mad(aux->DE, fabs(fractal->transformCommon.scale1), 1.0f);
	// aux->r_dz *= fabs(fractal->transformCommon.scale1);

	if (fractal->analyticDE.enabledFalse)
	{ // analytic log DE adjustment
		aux->r_dz *= fabs(fractal->transformCommon.scale1) * fractal->analyticDE.scale1;
	}
	else
	{
		aux->r_dz *= fabs(fractal->transformCommon.scale1);
	}
	return z;
}
#else
double4 EiffieMsltoeIteration(double4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	double4 c = aux->const_c;
	double psi = fabs(fmod(atan2(z.z, z.y) + M_PI + M_PI_8, M_PI_4) - M_PI_8);
	double lengthYZ = native_sqrt(mad(z.y, z.y, z.z * z.z));

	z.y = native_cos(psi) * lengthYZ;
	z.z = native_sin(psi) * lengthYZ;
	aux->r_dz = aux->r_dz * 2.0 * aux->r;

	double4 z2 = z * z;
	double rr = z2.x + z2.y + z2.z;
	double m = 1.0 - native_divide(z2.z, rr);
	double4 temp;
	temp.x = (z2.x - z2.y) * m;
	temp.y = 2.0 * z.x * z.y * m * fractal->transformCommon.scale; // scaling y;;
	temp.z = 2.0 * z.z * native_sqrt(z2.x + z2.y);
	temp.w = z.w;
	z = temp + fractal->transformCommon.additionConstant000;

	if (fractal->transformCommon.addCpixelEnabledFalse)
	{
		double4 tempFAB = c;
		if (fractal->transformCommon.functionEnabledx) tempFAB.x = fabs(tempFAB.x);
		if (fractal->transformCommon.functionEnabledy) tempFAB.y = fabs(tempFAB.y);
		if (fractal->transformCommon.functionEnabledz) tempFAB.z = fabs(tempFAB.z);

		tempFAB *= fractal->transformCommon.constantMultiplier000;
		z.x += copysign(tempFAB.x, z.x);
		z.y += copysign(tempFAB.y, z.y);
		z.z += copysign(tempFAB.z, z.z);
	}
	double lengthTempZ = length(-z);
	// if (lengthTempZ > -1e-21) lengthTempZ = -1e-21;   //  z is neg.)
	z *= 1.0 + native_divide(fractal->transformCommon.offset, lengthTempZ);
	z *= fractal->transformCommon.scale1;
	aux->DE = aux->DE * fabs(fractal->transformCommon.scale1) + 1.0;
	// aux->r_dz *= fabs(fractal->transformCommon.scale1);

	if (fractal->analyticDE.enabledFalse)
	{ // analytic log DE adjustment
		aux->r_dz *= fabs(fractal->transformCommon.scale1) * fractal->analyticDE.scale1;
	}
	else
	{
		aux->r_dz *= fabs(fractal->transformCommon.scale1);
	}
	return z;
}
#endif
