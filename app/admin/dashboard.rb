ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    ["created", "updated"].each do |order|
      h2 "Recently #{order}"
      columns do
        [Creation, Chapter, Badge].each do |klass|
          get_column(klass, order)
        end
        get_column(User, order, "name")
      end
    end

  end # content
end

def get_column(klass, order_by = "created", field = "title")
  column do
    panel "Recently #{order_by} #{klass.name.pluralize}" do
      ul do
        klass.order(order_by + "_at" => :desc).limit(10).map do |item|
          li link_to(item.send(field), send("admin_#{klass.name.downcase}_path", item))
        end
      end
    end
  end
end
