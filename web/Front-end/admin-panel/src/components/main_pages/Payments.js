import React, { useState } from 'react'
import useFetch from '../../hooks/useFetch'
import PaymentList from '../sub_pages/PaymentList'
import Loading from '../sub_pages/Loading'
import Breadcrumbs from '../sub_pages/Breadcrumbs'
import { useLocation } from 'react-router-dom'
import { getAllPaymentUrl } from '../sub_pages/BaseUrl'
import Pagination from '../sub_pages/Pagination'

const Payments = () => {
  const [searchTerm, setSearchTerm] = useState('')
  const [searchResult, setSearchResult] = useState([])
  const [currentPage, setcurrentPage] = useState(1)
  const [postsPerPage] = useState(10)
  const location = useLocation()
  // const token = localStorage.getItem('token')
  // const jwt = token.token

  const { data: payments, isPending, error } = useFetch(getAllPaymentUrl)
  var lastPostIndex = null
  var firstPostIndex = null
  var currentPosts = null

  const searchHandler = (searchTerm) => {
    setSearchTerm(searchTerm)
    if (searchTerm !== '') {
      const newPaymentList = payments.filter((payment) => {
        return Object.values(payment)
          .join(' ')
          .toLowerCase()
          .includes(searchTerm.toLowerCase())
      })
      setSearchResult(newPaymentList)
    } else {
      setSearchResult(payments)
    }
  }
  if (payments) {
    lastPostIndex = currentPage * postsPerPage
    firstPostIndex = lastPostIndex - postsPerPage
    currentPosts = payments.slice(firstPostIndex, lastPostIndex)
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
      {error && <div>{error}</div>}
      {payments && (
        <>
          <PaymentList
            payments={searchTerm.length < 1 ? currentPosts : searchResult}
            term={searchTerm}
            searchKeyword={searchHandler}
          />
          <Pagination
            totalPosts={payments.length}
            postsPerPage={postsPerPage}
            setcurrentPage={setcurrentPage}
            currentPage={currentPage}
          />
        </>
      )}
    </div>
  )
}

export default Payments
