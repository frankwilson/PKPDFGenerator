//
//  PdfGeneratorTable.swift
//  MyPriceList
//
//  Created by Pavel Kazantsev on 29/01/15.
//  Copyright (c) 2015 Pakaz.Ru. All rights reserved.
//
import UIKit

public protocol PDFTable {
    var columns: Array<PDFTableColumn> { get }

    var sectionsNumber: Int { get }

    func numberOfRowsInSection(section: Int) -> Int
    func titleForHeaderInSection(section: Int) -> String?
    func rowAtIndex(row: Int, section: Int) -> PDFTableRow
}

public struct PDFTableColumn {
    private(set) public var columnWidth: Float
    private(set) public var columnTitle: String
    private(set) public var propertyName: String
    private(set) public var textAttributes = Array<PDFTableTextAttribute>()

    public init(title: String, propertyName: String, width: Float = -1) {
        self.columnTitle = title
        self.columnWidth = width
        self.propertyName = propertyName
    }

    public mutating func addTextAttribute(attribute: PDFTableTextAttribute) {
        textAttributes.append(attribute)
    }
}

public struct PDFTableRow {
    public let rowCells: Array<PDFTableCell>

    public init(rowCells: Array<PDFTableCell>) {
        self.rowCells = rowCells
    }
}

public enum PDFTableCell {
    case EmptyCell(cellAttributes: Array<PDFTableCellAttribute>?)
    case TextCell(String, textAttributes: Array<PDFTableTextAttribute>?, cellAttributes: Array<PDFTableCellAttribute>?)
    case ImageCell(UIImage, cellAttributes: Array<PDFTableCellAttribute>?)
    case CustomCell((frame: CGRect) -> (), cellAttributes: Array<PDFTableCellAttribute>?)
}

public enum PDFTableTextAttribute {
    case Alignment(NSTextAlignment)

    case FontWeight(TextFontWeight, range: NSRange)
    case FontSizeAbsolute(Float, range: NSRange)
    case FontSizeRelative(Float, range: NSRange)

    public enum TextFontWeight {
        case Normal
        case Italic
        case Bold
    }
}

public enum PDFTableCellAttribute {
    case FrameWidth(FrameWidthAttribute)
    case FrameColor(UIColor)
    case FillColor(UIColor?) // Allows to reset fill color

    public enum FrameWidthAttribute {
        case NoWidth
        case Fixed(Float)
    }
}
