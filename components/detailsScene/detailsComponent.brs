sub init()
    m.genres = m.top.findNode("genresContent")
    m.overview = m.top.findNode("overview")
    m.rate = m.top.findNode("rateContent")
    m.productionCompanies = m.top.findNode("productionCompaniesContent")
end sub

sub showContent()
    content = m.top.content

    setGenres(content.genres)
    setProductionCompanies(content.production_companies)
    m.overview.text = content.overview
    m.rate.text = content.vote_average
end sub

sub setGenres(genres as object)
    genresText = ""

    for each genre in genres
        if genresText = "" then
            genresText = genre.name
        else
            genresText = genresText + ", " + genre.name
        end if
    end for

    m.genres.text = genresText
end sub

sub setProductionCompanies(companies as object)
    companiesText = ""

    for each companie in companies
        if companiesText = "" then
            companiesText = companie.name
        else
            companiesText = companiesText + ", " + companie.name
        end if
    end for

    m.productionCompanies.text = companiesText
end sub
