module ApplicationHelper
def resource_name
:customer
:admin

end

def resource
   @resource ||= Customer.new
   @resource ||= Admin.new
end

def devise_mapping
   @devise_mapping ||= Devise.mappings[:customer]
   @devise_mapping ||= Devise.mappings[:admin]
end
end
