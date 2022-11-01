import React from 'react'
import useFetch from '../../hooks/useFetch'
import AuthorsList from '../sub_pages/AuthorsList'
import Loading from '../sub_pages/Loading'
import Breadcrumbs from '../sub_pages/Breadcrumbs'
import { useLocation } from 'react-router-dom'
import { useState } from 'react'
import Pagination from '../sub_pages/Pagination'

function Authors() {
  const [searchTerm, setSearchTerm] = useState('')
  const [searchResult, setSearchResult] = useState([])
  const [currentPage, setcurrentPage] = useState(1)
  const [postsPerPage] = useState(10)
  const location = useLocation()
  const {
    data: authors,
    isPending,
    error,
  } = useFetch('https://localhost:7144/api/Author/GetAllAuthors')
   var lastPostIndex = null
   var firstPostIndex = null
   var currentPosts = null

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
    } else {
      setSearchResult(authors)
    }
  }
  if (authors) {
    lastPostIndex = currentPage * postsPerPage
    firstPostIndex = lastPostIndex - postsPerPage
    currentPosts = authors.slice(firstPostIndex, lastPostIndex)
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
      {error && <div className='text-red-600'>{error}</div>}
      {authors && (
        <>
          <AuthorsList
            authors={searchTerm.length < 1 ? currentPosts : searchResult}
            term={searchTerm}
            searchKeyword={searchHandler}
          />
          <Pagination
            totalPosts={authors.length}
            postsPerPage={postsPerPage}
            setcurrentPage={setcurrentPage}
            currentPage={currentPage}
          />
        </>
      )}
    </div>
  )
}

export default Authors
