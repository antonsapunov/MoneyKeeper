//
//  StatisticsView.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 4/3/21.
//

import SwiftUI
import SwiftUICharts

enum ChartType: String, CaseIterable {
    case lines = "Lines"
    case graph = "Graph"
}

struct StatisticsView: View {
    
    @State private var chartType: ChartType = .lines
    
    var body: some View {
        VStack(alignment: .center) {
            Picker(selection: $chartType, label: Text("What is your favorite color?")) {
                ForEach(ChartType.allCases, id: \.self) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .onChange(of: chartType, perform: { value in
                print(chartType)
            })
            getChartView(type: chartType)
            Text("Total: 1000$")
                .padding()
            Spacer()
        }
    }
    
    private func getChartView(type: ChartType) -> some View {
        let warmUp = Legend(color: .blue, label: "Warm Up", order: 2)
        let low = Legend(color: .gray, label: "Low", order: 1)

        let points: [DataPoint] = [
            .init(value: 70, label: "1", legend: low),
            .init(value: 90, label: "2", legend: warmUp),
            .init(value: 100, label: "3", legend: warmUp),
            .init(value: 111, label: "4", legend: warmUp)
        ]

        return HorizontalBarChartView(dataPoints: points)
            .padding()
//        switch type {
//        case .lines:
//            return AnyView(BarChartView(data: ChartData(values: [("2018 Q4",63150), ("2019 Q1",50900), ("2019 Q2",77550), ("2019 Q3",79600), ("2019 Q4",92550)]), title: "Sales", legend: "Quarterly", form: ChartForm.extraLarge)
//                .padding())
//        case .graph:
//            return AnyView(PieChartView(data: [8,23,54,32], title: "Title", legend: "Legendary", form:  ChartForm.large))
//        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatisticsView()
        }
    }
}
