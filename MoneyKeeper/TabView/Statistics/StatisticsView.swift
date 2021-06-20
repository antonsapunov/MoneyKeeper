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
    
    @EnvironmentObject var viewModel: StatisticsViewModel
    @State private var chartType: ChartType = .lines
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Picker(selection: $chartType, label: EmptyView()) {
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
                Text("Total spendings: " + viewModel.totalSpendings.formattedWithSeparator(2) + " $")
                    .font(.title2)
                    .padding()
                Spacer()
            }
            .navigationTitle("Statistics")
        }
    }
    
    private func getChartView(type: ChartType) -> some View {
        let categories = viewModel.categories
        var points: [DataPoint] = []
        for (index,category) in categories.enumerated() {
            let legend = Legend(
                color: Color.Chart.lines,
                label: LocalizedStringKey(category.name),
                order: index
            )
            points.append(
                DataPoint(
                    value: category.amount,
                    label: LocalizedStringKey(category.amount.formattedWithSeparator(2) + " $"),
                    legend: legend
                )
            )
        }

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
