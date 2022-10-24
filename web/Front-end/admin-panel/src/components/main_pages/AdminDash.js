// import Library from '../../images/OnlineLib.png'
// import Library1 from '../../images/library08.jpg'
import React from "react";
import { Link } from 'react-router-dom'

function Admin() {
  return (
    <div classNameName='container mx-auto md:px-8 mb-5 mt-5'>
      <div className='px-6 py-12 lg:my-12 md:px-12 text-gray-800 text-center lg:text-left'>
        <div className='container mx-auto xl:px-32'>
          <div className='grid lg:grid-cols-2 gap-12 '>
            <div className='mt-12 lg:mt-0'>
              <h1 className='text-4xl md:text-5xl xl:text-6xl font-bold tracking-tight mb-12'>
                The best books <br />
                <span className='text-blue-600'>for your studies</span>
              </h1>
              <Link
                className='inline-block px-7 py-3 mr-2 bg-blue-600 text-white font-medium text-sm leading-snug uppercase rounded shadow-md hover:bg-blue-700 hover:shadow-lg focus:bg-blue-700 focus:shadow-lg focus:outline-none focus:ring-0 active:bg-blue-800 active:shadow-lg transition duration-150 ease-in-out'
                data-mdb-ripple='true'
                data-mdb-ripple-color='light'
                to='#!'
                role='button'
              >
                Get started
              </Link>
              <Link
                className='inline-block px-7 py-3 bg-transparent text-blue-600 font-medium text-sm leading-snug uppercase rounded hover:text-blue-700 hover:bg-gray-100 focus:bg-gray-100 focus:outline-none focus:ring-0 active:bg-gray-200 transition duration-150 ease-in-out'
                data-mdb-ripple='true'
                data-mdb-ripple-color='light'
                to='#!'
                role='button'
              >
                Learn more
              </Link>
            </div>
            <div className='mb-12 lg:mb-0'>
              <img
                src='https://mdbootstrap.com/img/new/standard/city/017.jpg'
                className='w-full rounded-lg shadow-lg'
                alt=''
              />
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}

export default Admin
