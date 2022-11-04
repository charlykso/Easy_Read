import React from 'react'

const Loading = () => {
  return (
    <div className='absolute flex justify-center items-center min-h-full mt-5 top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 '>
      <div
        className='spinner-grow bg-purple-800 inline-block w-12 h-12 rounded-full '
        role='status'
      >
        <span className='visually-hidden'>Loading...</span>
      </div>
    </div>
  )
}

export default Loading
