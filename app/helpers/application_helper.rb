module ApplicationHelper
  def conditional_body(&block)
    raw %Q{<!--[if lt IE 7 ]><body class='ie6'><![endif]-->
      <!--[if IE 7 ]><body class='ie7'><![endif]-->
      <!--[if IE 8 ]><body class='ie8'><![endif]-->
      <!--[if IE 9 ]><body class='ie9'><![endif]-->
      <!--[if (gt IE 9)|!(IE)]><!--><body><!--<![endif]-->
      #{capture(&block)}
      </body>}
  end
end
