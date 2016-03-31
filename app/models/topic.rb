class Topic < ActiveRecord::Base
	
	def articles

		articles = Array.new 

		Tagging.where(:tag_id => self.id).each do |tagging|

			article = Article.find(tagging.article_id)

			articles << article

		end

		return articles.uniq

	end

	def related_topics


	end

	def child_topics



	end
end
