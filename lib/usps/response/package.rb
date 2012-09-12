module USPS::Response::Package
  autoload :DomesticPackage,      'usps/response/package/domestic_package'
  autoload :InternationalPackage, 'usps/response/package/international_package'
end
