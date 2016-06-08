module DeviseHelper
  def devise_error_messages!
    if resource.errors.empty?
      ""
    else
      "에러가 났다 소년 다시 잘 작성해보자"
    end
  end
end