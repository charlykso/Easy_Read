import React, { useState } from 'react'
import useFetch from '../../hooks/useFetch'
import UserList from '../sub_pages/UserList'
import Loading from '../sub_pages/Loading'
import Breadcrumbs from '../sub_pages/Breadcrumbs'
import { useLocation } from 'react-router-dom'
import { getAllUserUrl } from '../sub_pages/BaseUrl'
import Pagination from '../sub_pages/Pagination'

const Users = () => {
  const [searchTerm, setSearchTerm] = useState('')
  const [searchResult, setSearchResult] = useState([])
  const [currentPage, setcurrentPage] = useState(1)
  const [postsPerPage] = useState(10)
  const location = useLocation()
  // var history = useHistory()
  var lastPostIndex = null
  var firstPostIndex = null
  var currentPosts = null

  const { data: users, isPending, error } = useFetch(getAllUserUrl)

  if (users) {
    // console.log(location)
    lastPostIndex = currentPage * postsPerPage
    firstPostIndex = lastPostIndex - postsPerPage
    currentPosts = users.slice(firstPostIndex, lastPostIndex)
  }

  const searchHandler = (searchTerm) => {
    setSearchTerm(searchTerm)
    if (searchTerm !== '') {
      const newUserList = users.filter((user) => {
        return Object.values(user)
          .join(' ')
          .toLowerCase()
          .includes(searchTerm.toLowerCase())
      })
      setSearchResult(newUserList)
    } else {
      setSearchResult(users)
    }
  }

  return (
    <div className='container mx-auto md:px-8 min-h-screen'>
      {!isPending && (
        <Breadcrumbs
          location={location.pathname}
          userSearchKeyword={searchHandler}
        />
      )}
      {isPending && <Loading />}
      {error && <div className='text-red-600'>{error}</div>}
      {users && (
        <>
          <UserList
            users={searchTerm.length < 1 ? currentPosts : searchResult}
            term={searchTerm}
            searchKeyword={searchHandler}
          />
          <Pagination
            totalPosts={users.length}
            postsPerPage={postsPerPage}
            setcurrentPage={setcurrentPage}
            currentPage={currentPage}
          />
        </>
      )}
    </div>
  )
}

export default Users
