class BookDatatable < AjaxDatatablesRails::Base
include AjaxDatatablesRails::Extensions::Kaminari
  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= ['book.title' ,'book.author']
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= ['book.title' ,'book.author']
  end

  private

  def data
    records.map do |record|
      [
        record.title
        record.author
        record.category.name
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
      ]
    end
  end

  def get_raw_records
    # insert query here
    Book.all
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
