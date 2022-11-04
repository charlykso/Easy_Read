import React from "react";
import Carousel from '../sub_pages/Carousel'
// import Library1 from '../../images/reader.png'
import Study from '../../images/home_library_flat.jpg'
import { Link } from 'react-router-dom'
import NewUsers from '../sub_pages/New_users'
import { useEffect, useState } from "react";
import { ThreeDots } from 'react-loading-icons'

function Home() {
  const [pageFinishedLoaging, setPageFinishedLoading] = useState(false)

  useEffect(() => {
    // This will run one time after the component mounts
    const onPageLoad = () => {
      setPageFinishedLoading(true)
    }

    // Check if the page has already loaded
    if (document.readyState === 'complete') {
      onPageLoad()
    } else {
      window.addEventListener('load', onPageLoad)
      // Remove the event listener when component unmounts
      return () => window.removeEventListener('load', onPageLoad)
    }
  }, [])

  return (
    <div className='container mx-auto md:px-8 mb-5 mt-5'>
      <div className='relative libry'>
        {pageFinishedLoaging ? <Carousel /> : <ThreeDots />}
        {pageFinishedLoaging && (
          <>
            <h1 className='absolute text-5xl text-white top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2'>
              Welcome!
            </h1>
            <p className='absolute text-white top-1/2 left-[48%] -translate-x-[100px] -translate-y-[-25px]'>
              We take education to the next level.
            </p>
            <h3 className='absolute text-2xl text-blue-300 top-5 left-5'>
              <Link to='/'>Easyread</Link>
            </h3>
          </>
        )}
      </div>

      {pageFinishedLoaging && (
        <>
          <div className='flex flex-wrap items-center justify-items-end max-h-full mt-5 mb-5 sm:flex-wrap'>
            <div className='flex justify-center  max-h-[300px] lg:w-3/5 md:w-full sm:w-full'>
              <img className='' src={Study} alt='Library' />
            </div>
            <div className=' h-full rounded-lg lg:w-2/5 md:w-full sm:w-full xs:w-full'>
              {pageFinishedLoaging && <NewUsers />}
            </div>
          </div>
        </>
      )}
    </div>
  )
}

export default Home
