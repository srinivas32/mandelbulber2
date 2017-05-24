/**
* Mandelbulber v2, a 3D fractal generator       ,=#MKNmMMKmm�MNWy,
*                                             ,B" ]L,,p%%%,,,�;, "K
* Copyright (C) 2017 Mandelbulber Team        �R-==%w["'~5]m%=L.=~5N
*                                        ,=mm=�M ]=4 yJKA"/-Nsaj  "Bw,==,,
* This file is part of Mandelbulber.    �R.r= jw",M  Km .mM  FW ",�=�., ,TN
*                                     ,4R =%["w[N=7]J '"5=],""]]M,w,-; T=]M
* Mandelbulber is free software:     �R.�~-Q/M=,=5"v"]=Qf,'�"M= =,M.� Rz]M"Kw
* you can redistribute it and/or     �w "xDY.J ' -"m=====WeC=\ ""%""y=%"]"" �
* modify it under the terms of the    "�M=M =D=4"N #"%==A%p M� M6  R' #"=~.4M
* GNU General Public License as        �W =, ][T"]C  �  � '� e===~ U  !�[Z ]N
* published by the                    4M",,Jm=,"=e~  �  �  j]]""N  BmM"py=�M
* Free Software Foundation,          ]� T,M=& 'YmMMpM9MMM%=w=,,=MT]M m�;'�,
* either version 3 of the License,    TWw [.j"5=~N[=�%=%W,T ]R,"=="Y[LFT ]N
* or (at your option)                   TW=,-#"%=;[  =Q:["V""  ],,M.m == ]N
* any later version.                      J�"mr"] ,=,," =="""J]= M"M"]==�"
*                                          �= "=C=4 �"eM "=B:m|4"]#F,�~
* Mandelbulber is distributed in            "9w=,,]w em%wJ '"~" ,=,,�"
* the hope that it will be useful,                 . "K=  ,=RMMM�M"""
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
* Authors: Krzysztof Marczak (buddhi1980@gmail.com), Robert Pancoast (RobertPancoast77@gmail.com)
*
* These objects enable an OpenCL backend definition.
*/

#ifndef MANDELBULBER2_SRC_OPENCL_ENGINE_RENDER_FRACTAL_H_
#define MANDELBULBER2_SRC_OPENCL_ENGINE_RENDER_FRACTAL_H_

#include "opencl_engine.h"

#if defined(_MSC_VER)
#pragma warning(push)
#pragma warning(disable : 4005) // macro redefinition
#pragma warning(disable : 4996) // declared deprecated
#endif													// _MSC_VER

#ifdef USE_OPENCL
#include <CL/cl.hpp>
#include "../src/fractal_enums.h"
#include "../opencl/mandelbulber_cl_data.h"
#endif // USE_OPENCL

#if defined(_MSC_VER)
#pragma warning(pop)
#endif // _MSC_VER

class cImage;
class cFractalContainer;

class cOpenClEngineRenderFractal : public cOpenClEngine
{
	Q_OBJECT

public:
	cOpenClEngineRenderFractal(cOpenClHardware *hardware);
	~cOpenClEngineRenderFractal();

#ifdef USE_OPENCL
	void LoadSourcesAndCompile(const cParameterContainer *params) override;
	void SetParameters(const cParameterContainer *params, const cFractalContainer *fractals);
	bool PreAllocateBuffers(const cParameterContainer *params) override;
	bool ReAllocateImageBuffers();
	bool Render(cImage *image);

private:
	QString toCamelCase(const QString &s);

	sClInConstants *constantInBuffer;
	cl::Buffer *inCLConstBuffer;

	sClInBuff *inBuffer;
	cl::Buffer *inCLBuffer;

	sClPixel *rgbbuff;
	cl::Buffer *outCL;

	QStringList listOfUsedFormulas;

#endif

signals:
	void updateProgressAndStatus(const QString &text, const QString &progressText, double progress);
};

#endif /* MANDELBULBER2_SRC_OPENCL_ENGINE_RENDER_FRACTAL_H_ */