import React, {useState} from 'react'

const Pagination = ({
  totalPosts,
  postsPerPage,
  setcurrentPage,
  currentPage,
}) => {
    const [manyPages, setmanyPages] = useState(false)
  let pages = []

  for (let i = 1; i <= Math.ceil(totalPosts / postsPerPage); i++) {
    pages.push(i)
  }

  if (pages.length > 4) {
    setmanyPages(true)
  }
  const goPrevious = () => {
    if (currentPage === 1) {
        setcurrentPage(pages.length)
    }else{
        setcurrentPage(currentPage - 1)
    }
  }
  const goNext = () => {
    if (currentPage === (pages.length)) {
        setcurrentPage(1)
    }else{
        setcurrentPage(currentPage + 1)
    }
  }
  return (
    <div className='flex flex-row justify-center m-5'>
      <div className=''>
        {manyPages && (
          <button
            className='px-3 py-1 m-5 border border-blue-600 text-blue-600 rounded-lg hover:bg-blue-40'
            onClick={goPrevious}
          >
            Previous
          </button>
        )}
        {manyPages
          ? pages.map((page, index) => {
              return (
                <button
                  className={
                    page === currentPage
                      ? 'px-3 py-1 m-5 bg-blue-600 text-white rounded-lg hover:bg-blue-40'
                      : 'px-3 py-1 m-5 border border-blue-600 text-blue-600 rounded-lg hover:bg-blue-40'
                  }
                  key={index}
                  onClick={() => setcurrentPage(page)}
                >
                  {'......'}
                </button>
              )
            })
          : pages.map((page, index) => {
              return (
                <button
                  className={
                    page === currentPage
                      ? 'px-3 py-1 m-5 bg-blue-600 text-white rounded-lg hover:bg-blue-40'
                      : 'px-3 py-1 m-5 border border-blue-600 text-blue-600 rounded-lg hover:bg-blue-40'
                  }
                  key={index}
                  onClick={() => setcurrentPage(page)}
                >
                  {page}
                </button>
              )
            })}

        {/* <span className="text-white">...  ...</span> */}
        {manyPages && (
          <button
            className='px-3 py-1 m-5 border-blue-600 text-blue-600 rounded-lg hover:bg-blue-40'
            onClick={goNext}
          >
            Next
          </button>
        )}
      </div>
    </div>
  )
}

export default Pagination
