//******************************************************************************
// SCICHART® Copyright SciChart Ltd. 2011-2019. All rights reserved.
//
// Web: http://www.scichart.com
// Support: support@scichart.com
// Sales:   sales@scichart.com
//
// CustomFreeSurface3DChartView.swift is part of the SCICHART® Examples. Permission is hereby granted
// to modify, create derivative works, distribute and publish any part of this source
// code whether for commercial, private or personal use.
//
// The SCICHART® examples are distributed in the hope that they will be useful, but
// without any warranty. It is provided "AS IS" without warranty of any kind, either
// expressed or implied.
//******************************************************************************

class CustomFreeSurface3DChartView: SingleChartLayout3D {
    
    override func initExample() {
        let xAxis = SCINumericAxis3D()
        xAxis.growBy = SCIDoubleRange(min: 0.1, max: 0.1)
        let yAxis = SCINumericAxis3D()
        yAxis.growBy = SCIDoubleRange(min: 0.1, max: 0.1)
        let zAxis = SCINumericAxis3D()
        zAxis.growBy = SCIDoubleRange(min: 0.1, max: 0.1)
        
        let radialDistanceFunc: SCIUVFunc = { u, v in 5.0 + sin(5.0 * (u + v)) }
        let azimuthalAngleFunc: SCIUVFunc = { u, _ in u }
        let polarAngleFunc: SCIUVFunc = { _, v in v }
        
        let xFunc: SCIValueFunc = { r, theta, phi in r * sin(theta) * cos(phi) }
        let yFunc: SCIValueFunc = { r, theta, phi in r * cos(theta) }
        let zFunc: SCIValueFunc = { r, theta, phi in r * sin(theta) * sin(phi) }
        
        let ds = SCICustomSurfaceDataSeries3D(xType: .double, yType: .double, zType: .double, uSize: 30, vSize: 30, radialDistanceFunc: radialDistanceFunc, azimuthalAngleFunc: azimuthalAngleFunc, polarAngleFunc: polarAngleFunc, xFunc: xFunc, yFunc: yFunc, zFunc: zFunc, uMin: 0.0, uMax: Double.pi * 2, vMin: 0, vMax: Double.pi)
        
        let colors: [UInt32] = [0xFF00008B, 0xFF0000FF, 0xFF00FFFF, 0xFFADFF2F, 0xFFFFFF00, 0xFFFF0000, 0xFF8B0000]
        let stops: [Float] = [0.0, 0.1, 0.3, 0.5, 0.7, 0.9, 1.0]
        let palette = SCIGradientColorPalette(colors: colors, stops: stops, count: 7)
        
        let rs0 = SCIFreeSurfaceRenderableSeries3D()
        rs0.dataSeries = ds
        rs0.drawMeshAs = .solidWireframe
        rs0.stroke = 0x77228B22
        rs0.contourInterval = 0.1
        rs0.contourStroke = 0x77228B22
        rs0.strokeThickness = 2.0
        rs0.lightingFactor = 0.8
        rs0.meshColorPalette = palette
        
        rs0.paletteMinMaxMode = .relative
        rs0.paletteMinimum = SCIVector3(x: 0.0, y: 5.0, z: 0.0)
        rs0.paletteMaximum = SCIVector3(x: 0.0, y: 7.0, z: 0.0)
        
        SCIUpdateSuspender.usingWith(surface) {
            self.surface.xAxis = xAxis
            self.surface.yAxis = yAxis
            self.surface.zAxis = zAxis
            self.surface.renderableSeries.add(rs0)
            self.surface.chartModifiers.add(ExampleViewBase.createDefault3DModifiers())
        }
    }
}
