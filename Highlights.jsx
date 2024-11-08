import React from 'react';
import { Camera, Shield, Layers } from 'lucide-react';

const Highlights = () => {
  return (
    <section className="grid grid-cols-3 gap-8 py-16 px-8 bg-white">
      <div className="flex flex-col items-center">
        <Camera size={48} className="text-green-700 mb-4" />
        <h3 className="text-xl font-bold mb-2">A Fully</h3>
        <p className="text-gray-600">Decentralized P2P</p>
      </div>
      <div className="flex flex-col items-center">
        <Shield size={48} className="text-green-700 mb-4" />
        <h3 className="text-xl font-bold mb-2">Loan</h3>
        <p className="text-gray-600">Platform</p>
      </div>
      <div className="flex flex-col items-center">
        <Layers size={48} className="text-green-700 mb-4" />
        <h3 className="text-xl font-bold mb-2">Direct</h3>
        <p className="text-gray-600">connections, smart choices, easy access.</p>
      </div>
    </section>
  );
};

export default Highlights;