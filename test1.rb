# Show the code you would use for a database migration that added a field “permalink” to
# an existing table called “post”. The migration is to also create a permalink for every
# existing Post record based on the “title” field. You can use any method you want to
# convert title to become permalink, the only requirements being permalink must be based
# on title, must be constructed of only URL valid characters, and must be unique (even if
# another Post has the same title and converts to the same permalink).


class AddPermalinkToPosts < ActiveRecord::Migration
  def up
    add_column :posts, :permalink, :text
    add_index :posts, :permalink
    
    Post.find_each do |post|
      post_permalink = generate_permalink(post)
      unless post.permalink.present?
        post.update_attribute(:permalink, post_permalink)
      end
    end
  end
  
  def down
    remove_column :posts, :permalink, :text
  end
  
  private
    def generate_permalink(post)
      post_title = post.title.parameterize
      if permalink_present?(post_title)
        random_number = rand(1..1000)
        while permalink_present?("#{ post_title }-#{ random_number }")
          random_number = rand(1..1000)
        end
        generated_permalink = "#{ post_title }-#{ random_number }"
      else
        generated_permalink = post_title
      end
    end
    
    def permalink_present?(link)
      Post.where(permalink: link).any?
    end
end
