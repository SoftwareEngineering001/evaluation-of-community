module BasicsHelper
    def exact_match(searchwords)
        return searchwords.filter(Course.title == keyword)
    end
end
