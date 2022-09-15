import React from 'react'
import useFetch from '../../hooks/useFetch'
import AuthorsList from '../sub_pages/AuthorsList'
import Loading from '../sub_pages/Loading'
import Breadcrumbs from '../sub_pages/Breadcrumbs'
import { useLocation } from 'react-router-dom'
import { useState } from 'react'

function Authors() {
  const [searchTerm, setSearchTerm] = useState('')
  const [searchResult, setSearchResult] = useState([])
  const location = useLocation()
  const {
    data: authors,
    isPending,
    error,
  } = useFetch('https://localhost:7144/api/Author/GetAllAuthors')

  // setSearchTerm("good one")

  const searchHandler = (searchTerm) => {
    setSearchTerm(searchTerm)
    if (searchTerm !== '') {
      const newAuthorList = authors.filter((author) => {
        return Object.values(author)
          .join(' ')
          .toLowerCase()
          .includes(searchTerm.toLowerCase())
      })
      setSearchResult(newAuthorList)
    }
    else{
      setSearchResult(authors)
    }
  }
  return (
    <div className='container mx-auto md:px-8'>
      {!isPending && (
        <Breadcrumbs
          location={location.pathname}
          searchKeyword={searchHandler}
        />
      )}
      {isPending && <Loading />}
      {error && <div>{error}</div>}
      {authors && (
        <AuthorsList
          authors={searchTerm.length < 1 ? authors : searchResult}
          term={searchTerm}
          searchKeyword={searchHandler}
        />
      )}
    </div>
  )
}

export default Authors
