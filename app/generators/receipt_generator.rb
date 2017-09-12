require_relative 'document_generator'

class ReceiptGenerator < InvoiceGenerator

  def customer
    {legal_name: "PERCY WOEDS CHAVEZ", dni: "09933494"}
  end

  def document_class
    SUNAT::Receipt
  end
end