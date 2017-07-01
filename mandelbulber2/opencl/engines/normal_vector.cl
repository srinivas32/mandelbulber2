/**
 * Mandelbulber v2, a 3D fractal generator       ,=#MKNmMMKmmßMNWy,
 *                                             ,B" ]L,,p%%%,,,§;, "K
 * Copyright (C) 2017 Mandelbulber Team        §R-==%w["'~5]m%=L.=~5N
 *                                        ,=mm=§M ]=4 yJKA"/-Nsaj  "Bw,==,,
 * This file is part of Mandelbulber.    §R.r= jw",M  Km .mM  FW ",§=ß., ,TN
 *                                     ,4R =%["w[N=7]J '"5=],""]]M,w,-; T=]M
 * Mandelbulber is free software:     §R.ß~-Q/M=,=5"v"]=Qf,'§"M= =,M.§ Rz]M"Kw
 * you can redistribute it and/or     §w "xDY.J ' -"m=====WeC=\ ""%""y=%"]"" §
 * modify it under the terms of the    "§M=M =D=4"N #"%==A%p M§ M6  R' #"=~.4M
 * GNU General Public License as        §W =, ][T"]C  §  § '§ e===~ U  !§[Z ]N
 * published by the                    4M",,Jm=,"=e~  §  §  j]]""N  BmM"py=ßM
 * Free Software Foundation,          ]§ T,M=& 'YmMMpM9MMM%=w=,,=MT]M m§;'§,
 * either version 3 of the License,    TWw [.j"5=~N[=§%=%W,T ]R,"=="Y[LFT ]N
 * or (at your option)                   TW=,-#"%=;[  =Q:["V""  ],,M.m == ]N
 * any later version.                      J§"mr"] ,=,," =="""J]= M"M"]==ß"
 *                                          §= "=C=4 §"eM "=B:m|4"]#F,§~
 * Mandelbulber is distributed in            "9w=,,]w em%wJ '"~" ,=,,ß"
 * the hope that it will be useful,                 . "K=  ,=RMMMßM"""
 * but WITHOUT ANY WARRANTY;                            .'''
 * without even the implied warranty
 * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *
 * See the GNU General Public License for more details.
 * You should have received a copy of the GNU General Public License
 * along with Mandelbulber. If not, see <http://www.gnu.org/licenses/>.
 *
 * ###########################################################################
 *
 * Authors: Krzysztof Marczak (buddhi1980@gmail.com)
 *
 * Normal vector calculation for opencl
 */

float3 NormalVector(__constant sClInConstants *consts, float3 point, float mainDistance,
	float distThresh, sClCalcParams *calcParam)
{
#ifndef SLOW_SHADING
	float delta = distThresh;
	calcParam->distThresh = distThresh;
	float s1 = CalculateDistance(consts, point + (float3){delta, 0.0f, 0.0f}, calcParam).distance;
	float s2 = CalculateDistance(consts, point + (float3){0.0f, delta, 0.0f}, calcParam).distance;
	float s3 = CalculateDistance(consts, point + (float3){0.0f, 0.0f, delta}, calcParam).distance;
	float3 normal = (float3){s1 - mainDistance, s2 - mainDistance, s3 - mainDistance};
	normal = normalize(normal);
	return normal;
#else

	// calculating normal vector based on average value of binary central difference

	float3 point2;
	float3 point3;
	float delta = distThresh * consts->params.smoothness * 0.5f;

	calcParam->distThresh = distThresh;

	float3 normal = 0.0f;
	for (point2.x = -1.0; point2.x <= 1.0; point2.x += 0.2) //+0.2
	{
		for (point2.y = -1.0; point2.y <= 1.0; point2.y += 0.2)
		{
			for (point2.z = -1.0; point2.z <= 1.0; point2.z += 0.2)
			{
				point3 = point + point2 * delta;
				float dist = CalculateDistance(consts, point3, calcParam).distance;
				normal += point2 * dist;
			}
		}
	}

	normal = normalize(normal);
	return normal;
#endif

	// TODO add brute force calculation of normal vector
}
