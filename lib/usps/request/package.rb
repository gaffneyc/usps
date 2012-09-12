module USPS::Request::Package
  autoload :Base,                 'usps/request/package/base'
  autoload :DomesticPackage,      'usps/request/package/domestic_package'
  autoload :InternationalPackage, 'usps/request/package/international_package'
end
