require 'syntax/convertors/html'

class ProjectRemarkablyController < DarkArtsController
  map '/project/remarkably'
  trait :engine => Ramaze::Template::Remarkably
  template_root 'src/projects/remarkably/view'

  include Remarkably::Common

  def index
    @project = Database::Project.find_one do |project|
      project.unixname == 'remarkably'
    end
  end
end
