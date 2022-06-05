//
//  StatisticsView.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 4/3/21.
//

import SwiftUI
import SwiftUICharts

enum ChartType: CaseIterable {
    case lines
    case graph
    
    var title: String {
        switch self {
        case .lines:
            return Constants.lines
        case .graph:
            return Constants.graph
        }
    }
}

struct StatisticsView: View {
    
    @EnvironmentObject var viewModel: StatisticsViewModel
    @State private var chartType: ChartType = .lines
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Picker(selection: $chartType, label: EmptyView()) {
                    ForEach(ChartType.allCases, id: \.self) { type in
                        Text(type.title).tag(type)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                getChartView(type: chartType)
                Text(Constants.totalSpendings + viewModel.totalSpendings.formattedWithSeparator(2) + " $")
                    .font(.title2)
                    .padding()
                Spacer()
            }
            .navigationTitle(Constants.statistics)
        }
    }
    
    private func getChartView(type: ChartType) -> some View {
        let categories = viewModel.categories
        switch type {
        case .lines:
            return AnyView(getBarChart(categories: categories)).padding()
        case .graph:
            return AnyView(getPieChart(categories: categories)).padding()
        }
    }
    
    private func getBarChart(categories: [Category]) -> some View {
        let points: [BarChartDataPoint] = categories.compactMap { category in
            guard category.amount != 0 else { return nil }
            return BarChartDataPoint(
                value: category.amount,
                xAxisLabel: category.name + " " + category.amount.formattedWithSeparator(2) + " $",
                description: category.amount.formattedWithSeparator(2) + " $",
                colour: ColourStyle(colour: category.type.defaultColor)
            )
        }
        let data = HorizontalBarChartData(dataSets: BarDataSet(dataPoints: points), barStyle: .init(colourFrom: ColourFrom.dataPoints))
        return HorizontalBarChart(chartData: data)
            .yAxisLabels(chartData: data)
            .frame(minWidth: 300, maxWidth: 600, minHeight: 300, maxHeight: 600, alignment: .center)
    }
    
    private func getPieChart(categories: [Category]) -> some View {
        let points: [PieChartDataPoint] = categories.compactMap { category in
            guard category.amount != 0 else { return nil }
            return PieChartDataPoint(
                value: category.amount,
                colour: category.type.defaultColor,
                label: .label(text: category.name + "\n" + category.amount.formattedWithSeparator(2) + " $", colour: Color.Chart.text, font: .title2, rFactor: 1.6)
            )
        }
        return PieChart(chartData:
            PieChartData(
                dataSets: PieDataSet(
                    dataPoints: points,
                    legendTitle: "Pie"
                ),
                metadata: ChartMetadata()
            )
        ).frame(minWidth: 100, maxWidth: 200, minHeight: 100, maxHeight: 600, alignment: .center)
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatisticsView()
        }
    }
}
