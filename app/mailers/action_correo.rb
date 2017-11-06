class ActionCorreo < ApplicationMailer
  	  default from: 'percywoeds@gmail.com'

	  def bienvenido_email(invoice)
		  @invoices=invoice 			
		   @url  = 'http://www.tpereda.com.pe'
		  #attachments["Factura"] = File.read("#{$lcFileName1}")
		  #attachments['Factura'] = File.read($lcFileName1)

		  email_with_name = "Factura Enviada <facturaselectronicas@tpereda.com.pe>"	
		  email_with_copy = "Operaciones <operaciones@tpereda.com.pe>"	

		  attachments[$lcFileName] =  open($lcFileName1).read

		  attachments[$lcFilezip] =  open($lcFile2).read

		  mail(to: [$lcMail,$lcMail2,$lcMail3], cc: email_with_copy,   bcc:email_with_name, subject: 'Factura Electrónica : '+$lcFileNameIni )

	  end
end
